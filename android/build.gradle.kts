allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// تغيير مجلد البناء إلى مسار مخصص
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()

rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    // تعيين مجلد البناء لكل subproject داخل المجلد الجديد
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(newSubprojectBuildDir)

    // تأكد من تقييم مشروع :app قبل المشاريع الفرعية الأخرى (إذا لزم الأمر)
    project.evaluationDependsOn(":app")
}

// مهمة تنظيف مجلد البناء الرئيسي
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
