from django.urls import path, include,re_path
from rest_framework.routers import DefaultRouter
from django.conf.urls import url

from home.api.v1.viewsets import (
    SignupViewSet,
    LoginViewSet, FacebookLogin, GoogleLogin, FacebookConnect
)

router = DefaultRouter()
router.register("signup", SignupViewSet, basename="signup")
router.register("login", LoginViewSet, basename="login")

urlpatterns = [
    path("", include(router.urls)),
    re_path(r"^login/google/$", GoogleLogin.as_view(), name="google_login"),
    re_path(r"^login/facebook/$", FacebookLogin.as_view(), name="facebook_login"),
    re_path(r"^login/linkedin/$", FacebookLogin.as_view(), name="facebook_login"),
    url(
        r"^password-reset/",
        include("django_rest_passwordreset.urls", namespace="password_reset"),
    ),
]
