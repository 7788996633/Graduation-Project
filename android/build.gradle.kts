// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // إضافة Google Services Plugin لتفعيل Firebase
        classpath("com.google.gms:google-services:4.3.15")
    }
}

// إعداد المستودعات لجميع المشاريع
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
