library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("Gochi Hand", "gochi")
## Automatically use showtext to render text for future devices
showtext_auto()

## use the ggplot2 example
library(hexSticker)

library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("RocknRoll One", "rockn")
font_add_google("Alfa Slab One", "alfa")
font_add_google("Ultra", "ultra")
font_add_google("Paytone One", "paytone")
font_add_google("Courgette", "courgette")
font_add_google("Love Ya Like A Sister", "lovesister")
font_add_google("Sue Ellen Francisco", "sue")
font_add_google("Limelight", "limelight")
font_add_google("Wendy One", "wendy")
font_add_google("Arbutus", "arbutus")
font_add_google("Londrina Shadow", "shadow")
# font_add_google("", "")
## Automatically use showtext to render text for future devices
showtext_auto()

sticker("man/figures/linie_purpur_gedreht.png",
        package = "sprtt",
        filename = "man/figures/sprtt_logo_alfa.png",
        # Schrift
        p_color = "#c9144e",
        p_size = 70,    #70
        p_family = "alfa",
        # p_fontface = "bold",
        #subplot
        s_width = 1.9,
        s_height = 0,
        s_x = 0.95,
        #URL
        url = "  meikesteinhilber.github.io/sprtt/",
        u_color =  "#474f5c",      #    "#8c0e36",
        u_size = 8,
        u_x = 1,
        u_y = 0.10,
        # Rahmen
        h_color = "#474f5c",
        h_fill =  "#cedbf0",        #"#cedbf0", "#b0a5a9",
        white_around_sticker = FALSE,
        dpi = 600,
        #spotlight
        spotlight = TRUE,
        l_alpha = 0.99,
        l_x = 1.011, # 1 ist mitte
        l_y = 1.2, # 1 ist mitte
        l_width = 8
)


# Run to build & detect logo
pkgdown::build_favicons(pkg = ".", overwrite = TRUE)
