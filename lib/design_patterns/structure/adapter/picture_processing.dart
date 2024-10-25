///图像处理应用程序，目前该应用程序只支持处理 PNG 格式的图片。随着需求的变化，用户希望能够处理 JPEG 和 BMP 格式的图片。
///然而，现有的系统只定义了一个 ImageProcessor 接口来处理 PNG 图片，JPEG 和 BMP 有各自不同的接口。
//
// 你需要使用适配器模式来将 JPEG 和 BMP 格式的图片处理类适配到现有的 ImageProcessor 接口上，以便在不修改现有系统的情况下，支持多种图片格式的处理。
//
// 需要实现的接口：
// ImageProcessor：现有系统的图片处理接口，只支持 PNG 格式。
// JpegProcessor 和 BmpProcessor：分别处理 JPEG 和 BMP 图片，但它们的接口不同于 ImageProcessor。
// JpegAdapter 和 BmpAdapter：使用适配器模式将 JPEG 和 BMP 的处理接口适配到 ImageProcessor 接口上。
// 你可以根据这个场景来尝试实现适配器模式，将不同格式的图像处理类适配到统一的接口。


mixin ImageProcessor{



}


