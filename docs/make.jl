using Documenter, Generators

DocMeta.setdocmeta!(Generators, :DocTestSetup, :(using Generators), recursive = true)
makedocs(sitename="fred.com", modules=[Generators], format = Documenter.HTML())
