return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "VeryLazy",
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1,
      request_timeout = 5,
      context_window = 8192,
      throttle = 800,
      debounce = 300,

      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "llama.cpp",
          end_point = "http://127.0.0.1:8012/v1/completions",
          model = "Qwen2.5-Coder-1.5B",
          stream = true,
          optional = {
            max_tokens = 128,
            top_p = 0.9,
            temperature = 0.2,
          },
          template = {
            prompt = function(prefix, suffix)
              return "<|fim_prefix|>" .. prefix .. "<|fim_suffix|>" .. suffix .. "<|fim_middle|>"
            end,
            suffix = false,
          },
        },
      },

      virtualtext = {
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = {
          "Avante",
          "gitcommit",
          "gitrebase",
          "help",
          "markdown",
          "text",
        },
        keymap = {
          accept = "<M-l>",
          accept_line = "<M-a>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    },
  },
}
