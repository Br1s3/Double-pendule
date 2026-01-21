CC = gcc


ifeq ($(OS), Windows_NT)
	PLATFORM := Windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S), Linux)
		PLATFORM := Linux
	else ifeq ($(UNAME_S), Darwin)
		PLATFORM := macos
	else
		PLATFORM := unknown
	endif
endif


ifeq ($(PLATFORM), Windows)
	MD = mkdir
	RM = del
	EXEC = .\main.exe
else ifeq ($(PLATFORM), Linux)
	MD = mkdir -p
	RM = rm -rf
	EXEC   = main
endif


BUILD_DIR 	:= project
OBJ_DIR 	:= lib
PICTURE_DIR 	:= stock

PICTURE_DB_PENDULUM := Double_pendulum_%03d.ppm
PICTURE_DB_SAMPLE := Double_pendulum_000.ppm
VIDEO_DB_PENDULUM := Double_pendulum.mp4

FLAGS += 		\
-Wall -Wextra 		\
-Wno-unused-function 	\

RAY_FLAGS += 	\
-lraylib	\
-lGL		\
-lm		\
-lpthread	\
-ldl		\
-lrt		\
-lX11 		\



.PHONY: all clean_all help create_picture create_video play_video create_gif



all: $(BUILD_DIR) $(PICTURE_DIR) $(BUILD_DIR)/simple_pendulum $(BUILD_DIR)/double_pendulum_console $(BUILD_DIR)/double_pendulum_video $(BUILD_DIR)/double_pendulum


$(BUILD_DIR):
	$(MD) $(BUILD_DIR)

$(PICTURE_DIR):
	$(MD) $(PICTURE_DIR)

$(BUILD_DIR)/simple_pendulum: simple_pendulum.c | $(BUILD_DIR)
	$(CC) simple_pendulum.c -o $(BUILD_DIR)/simple_pendulum $(FLAGS) $(RAY_FLAGS)

$(BUILD_DIR)/double_pendulum: double_pendulum.c | $(BUILD_DIR)
	$(CC) double_pendulum.c -o $(BUILD_DIR)/double_pendulum $(FLAGS) $(RAY_FLAGS)

$(BUILD_DIR)/double_pendulum_console: double_pendulum_console.c | $(BUILD_DIR)
	$(CC) double_pendulum_console.c -o $(BUILD_DIR)/double_pendulum_console $(FLAGS) -lm

$(BUILD_DIR)/double_pendulum_video: double_pendulum_video.c | $(BUILD_DIR) $(PICTURE_DIR)
	$(CC) double_pendulum_video.c -o $(BUILD_DIR)/double_pendulum_video $(FLAGS) -lm



play_video: $(PICTURE_DIR)/Double_pendulum.mp4
	mpv $(PICTURE_DIR)/Double_pendulum.mp4 --loop-file=yes

create_gif: $(PICTURE_DIR)/Double_pendulum.mp4
	ffmpeg -i $(PICTURE_DIR)/Double_pendulum.mp4 -vf "fps=15,scale=500:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" $(PICTURE_DIR)/Double_pendulum.gif

create_video: $(PICTURE_DIR)/Double_pendulum.mp4

$(PICTURE_DIR)/Double_pendulum.mp4: $(PICTURE_DIR)/$(PICTURE_DB_SAMPLE)
	ffmpeg -i $(PICTURE_DIR)/$(PICTURE_DB_PENDULUM) -r 60 $(PICTURE_DIR)/Double_pendulum.mp4

$(PICTURE_DIR)/$(PICTURE_DB_SAMPLE): $(BUILD_DIR)/double_pendulum_video
	./$(BUILD_DIR)/double_pendulum_video

clean:
	$(RM) $(PICTURE_DIR)
	$(RM) $(BUILD_DIR)
	$(RM) *.csv

help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... create_video"
	@echo "... play_video"
	@echo "... create_gif"
	@echo "... help"
