terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token                    = "y0_AgAAAAAJ89LzAATuwQAAAADXw9Jg9c02CFcWRByVNmiLPNOJSPw0xPA"
  cloud_id                 = "b1gc7onttnadnivcrdpf"
  folder_id                = "b1g43aq7nnnac7rsogvm"
  zone                     = "ru-central1-a"
}
