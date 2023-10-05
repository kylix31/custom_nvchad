local chatgpt = require "chatgpt"

chatgpt.setup {
  openai_params = {
    model = "gpt-3.5-turbo",
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 1000,
    temperature = 0,
    top_p = 1,
    n = 1,
  },
  chat = {
    welcome_message = "I WILL BE BACK!",
    loading_text = "creating Skinet...",
    question_sign = "",
    answer_sign = "ﮧ",
    max_line_length = 120,
    sessions_window = {
      border = {
        style = "rounded",
        text = {
          top = " Sessions ",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
  },
  popup_window = {
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top = " SKYNET V.00001 ",
      },
    },
  },
}
