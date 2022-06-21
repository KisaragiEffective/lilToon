Shader "Hidden/ltsother_baker"
{
    Properties
    {
        //----------------------------------------------------------------------------------------------------------------------
        // Main
        [lilHDR]        _Color                      ("Color", Color) = (1,1,1,1)
        [MainTexture]   _MainTex                    ("Texture", 2D) = "white" {}
        [lilUVAnim]     _MainTex_ScrollRotate       ("Angle|UV Animation|Scroll|Rotate", Vector) = (0,0,0,0)
        [lilHSVG]       _MainTexHSVG                ("Hue|Saturation|Value|Gamma", Vector) = (0,1,1,1)
                        _MainGradationStrength      ("Gradation Strength", Range(0, 1)) = 0
        [NoScaleOffset] _MainGradationTex           ("Gradation Map", 2D) = "white" {}
        [NoScaleOffset] _MainColorAdjustMask        ("Adjust Mask", 2D) = "white" {}

        //----------------------------------------------------------------------------------------------------------------------
        // Main2nd
        [lilToggleLeft] _UseMain2ndTex              ("Use Main 2nd", Int) = 0
                        _Color2nd                   ("Color", Color) = (1,1,1,1)
                        _Main2ndTex                 ("Texture", 2D) = "white" {}
        [lilAngle]      _Main2ndTexAngle            ("Angle", Float) = 0
        [lilToggle]     _Main2ndTexIsDecal          ("As Decal", Int) = 0
        [lilToggle]     _Main2ndTexIsLeftOnly       ("Left Only", Int) = 0
        [lilToggle]     _Main2ndTexIsRightOnly      ("Right Only", Int) = 0
        [lilToggle]     _Main2ndTexShouldCopy       ("Copy", Int) = 0
        [lilToggle]     _Main2ndTexShouldFlipMirror ("Flip Mirror", Int) = 0
        [lilToggle]     _Main2ndTexShouldFlipCopy   ("Flip Copy", Int) = 0
        [lilToggle]     _Main2ndTexIsMSDF           ("As MSDF", Int) = 0
        [NoScaleOffset] _Main2ndBlendMask           ("Mask", 2D) = "white" {}
        [lilEnum]       _Main2ndTexBlendMode        ("Blend Mode|Normal|Add|Screen|Multiply", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Main3rd
        [lilToggleLeft] _UseMain3rdTex              ("Use Main 3rd", Int) = 0
                        _Color3rd                   ("Color", Color) = (1,1,1,1)
                        _Main3rdTex                 ("Texture", 2D) = "white" {}
        [lilAngle]      _Main3rdTexAngle            ("Angle", Float) = 0
        [lilToggle]     _Main3rdTexIsDecal          ("As Decal", Int) = 0
        [lilToggle]     _Main3rdTexIsLeftOnly       ("Left Only", Int) = 0
        [lilToggle]     _Main3rdTexIsRightOnly      ("Right Only", Int) = 0
        [lilToggle]     _Main3rdTexShouldCopy       ("Copy", Int) = 0
        [lilToggle]     _Main3rdTexShouldFlipMirror ("Flip Mirror", Int) = 0
        [lilToggle]     _Main3rdTexShouldFlipCopy   ("Flip Copy", Int) = 0
        [lilToggle]     _Main3rdTexIsMSDF           ("As MSDF", Int) = 0
        [NoScaleOffset] _Main3rdBlendMask           ("Mask", 2D) = "white" {}
        [lilEnum]       _Main3rdTexBlendMode        ("Blend Mode|Normal|Add|Screen|Multiply", Int) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Alpha Mask
        [lilEnumLabel]  _AlphaMaskMode              ("AlphaMask|", Int) = 0
        [NoScaleOffset] _AlphaMask                  ("AlphaMask", 2D) = "white" {}
                        _AlphaMaskScale             ("Scale", Float) = 1
                        _AlphaMaskValue             ("Offset", Float) = 0

        //----------------------------------------------------------------------------------------------------------------------
        // Texture Packing
        [NoScaleOffset] _PackingTexture1            ("Texture", 2D) = "white" {}
        [NoScaleOffset] _PackingTexture2            ("Texture", 2D) = "white" {}
        [NoScaleOffset] _PackingTexture3            ("Texture", 2D) = "white" {}
        [NoScaleOffset] _PackingTexture4            ("Texture", 2D) = "white" {}
                        _PackingChannel1            ("Channel", Int) = 0
                        _PackingChannel2            ("Channel", Int) = 0
                        _PackingChannel3            ("Channel", Int) = 0
                        _PackingChannel4            ("Channel", Int) = 0
    }

    SubShader
    {
        HLSLINCLUDE
            #define LIL_FEATURE_ANIMATE_MAIN_UV
            #define LIL_FEATURE_MAIN_TONE_CORRECTION
            #define LIL_FEATURE_MAIN_GRADATION_MAP
            #define LIL_FEATURE_MAIN2ND
            #define LIL_FEATURE_MAIN3RD
            #define LIL_FEATURE_DECAL
            #define LIL_FEATURE_ANIMATE_DECAL
            #define LIL_FEATURE_LAYER_DISSOLVE
            #define LIL_FEATURE_ALPHAMASK
            #define LIL_FEATURE_SHADOW
            #define LIL_FEATURE_RECEIVE_SHADOW
            #define LIL_FEATURE_SHADOW_3RD
            #define LIL_FEATURE_EMISSION_1ST
            #define LIL_FEATURE_EMISSION_2ND
            #define LIL_FEATURE_ANIMATE_EMISSION_UV
            #define LIL_FEATURE_ANIMATE_EMISSION_MASK_UV
            #define LIL_FEATURE_EMISSION_GRADATION
            #define LIL_FEATURE_NORMAL_1ST
            #define LIL_FEATURE_NORMAL_2ND
            #define LIL_FEATURE_ANISOTROPY
            #define LIL_FEATURE_REFLECTION
            #define LIL_FEATURE_MATCAP
            #define LIL_FEATURE_MATCAP_2ND
            #define LIL_FEATURE_RIMLIGHT
            #define LIL_FEATURE_RIMLIGHT_DIRECTION
            #define LIL_FEATURE_GLITTER
            #define LIL_FEATURE_BACKLIGHT
            #define LIL_FEATURE_PARALLAX
            #define LIL_FEATURE_POM
            #define LIL_FEATURE_DISTANCE_FADE
            #define LIL_FEATURE_AUDIOLINK
            #define LIL_FEATURE_AUDIOLINK_VERTEX
            #define LIL_FEATURE_AUDIOLINK_LOCAL
            #define LIL_FEATURE_DISSOLVE
            #define LIL_FEATURE_OUTLINE_TONE_CORRECTION
            #define LIL_FEATURE_ANIMATE_OUTLINE_UV
            #define LIL_FEATURE_FUR_COLLISION
            #define LIL_FEATURE_MainGradationTex
            #define LIL_FEATURE_MainColorAdjustMask
            #define LIL_FEATURE_Main2ndTex
            #define LIL_FEATURE_Main2ndBlendMask
            #define LIL_FEATURE_Main2ndDissolveMask
            #define LIL_FEATURE_Main2ndDissolveNoiseMask
            #define LIL_FEATURE_Main3rdTex
            #define LIL_FEATURE_Main3rdBlendMask
            #define LIL_FEATURE_Main3rdDissolveMask
            #define LIL_FEATURE_Main3rdDissolveNoiseMask
            #define LIL_FEATURE_AlphaMask
            #define LIL_FEATURE_BumpMap
            #define LIL_FEATURE_Bump2ndMap
            #define LIL_FEATURE_Bump2ndScaleMask
            #define LIL_FEATURE_AnisotropyTangentMap
            #define LIL_FEATURE_AnisotropyScaleMask
            #define LIL_FEATURE_AnisotropyShiftNoiseMask
            #define LIL_FEATURE_ShadowBorderMask
            #define LIL_FEATURE_ShadowBlurMask
            #define LIL_FEATURE_ShadowStrengthMask
            #define LIL_FEATURE_ShadowColorTex
            #define LIL_FEATURE_Shadow2ndColorTex
            #define LIL_FEATURE_Shadow3rdColorTex
            #define LIL_FEATURE_BacklightColorTex
            #define LIL_FEATURE_SmoothnessTex
            #define LIL_FEATURE_MetallicGlossMap
            #define LIL_FEATURE_ReflectionColorTex
            #define LIL_FEATURE_ReflectionCubeTex
            #define LIL_FEATURE_MatCapTex
            #define LIL_FEATURE_MatCapBlendMask
            #define LIL_FEATURE_MatCapBumpMap
            #define LIL_FEATURE_MatCap2ndTex
            #define LIL_FEATURE_MatCap2ndBlendMask
            #define LIL_FEATURE_MatCap2ndBumpMap
            #define LIL_FEATURE_RimColorTex
            #define LIL_FEATURE_GlitterColorTex
            #define LIL_FEATURE_GlitterShapeTex
            #define LIL_FEATURE_EmissionMap
            #define LIL_FEATURE_EmissionBlendMask
            #define LIL_FEATURE_EmissionGradTex
            #define LIL_FEATURE_Emission2ndMap
            #define LIL_FEATURE_Emission2ndBlendMask
            #define LIL_FEATURE_Emission2ndGradTex
            #define LIL_FEATURE_ParallaxMap
            #define LIL_FEATURE_AudioLinkMask
            #define LIL_FEATURE_AudioLinkLocalMap
            #define LIL_FEATURE_DissolveMask
            #define LIL_FEATURE_DissolveNoiseMask
            #define LIL_FEATURE_OutlineTex
            #define LIL_FEATURE_OutlineWidthMask
            #define LIL_FEATURE_OutlineVectorTex
            #define LIL_FEATURE_FurNoiseMask
            #define LIL_FEATURE_FurMask
            #define LIL_FEATURE_FurLengthMask
            #define LIL_FEATURE_FurVectorTex
            #define LIL_OPTIMIZE_APPLY_SHADOW_FA
            #define LIL_OPTIMIZE_USE_FORWARDADD
            #define LIL_OPTIMIZE_USE_VERTEXLIGHT
            #pragma skip_variants LIGHTMAP_ON DYNAMICLIGHTMAP_ON LIGHTMAP_SHADOW_MIXING SHADOWS_SHADOWMASK DIRLIGHTMAP_COMBINED _MIXED_LIGHTING_SUBTRACTIVE
            
        ENDHLSL

        Pass
        {
            Cull Off
            ZWrite Off
            ZTest Always
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma shader_feature _ _TRIMASK _ALPHAMASK _NORMAL_DXGL _TEXTURE_PACKING

            //------------------------------------------------------------------------------------------------------------------
            // Shader
            #define LIL_BAKER
            #define LIL_WITHOUT_ANIMATION
            #include "Assets/lilToon/Shader/Includes/lil_pipeline.hlsl"
            #include "Assets/lilToon/Shader/Includes/lil_common_appdata.hlsl"

            TEXTURE2D(_PackingTexture1);
            TEXTURE2D(_PackingTexture2);
            TEXTURE2D(_PackingTexture3);
            TEXTURE2D(_PackingTexture4);
            uint _PackingChannel1;
            uint _PackingChannel2;
            uint _PackingChannel3;
            uint _PackingChannel4;

            struct v2f
            {
                float4 positionCS   : SV_POSITION;
                float2 uv0          : TEXCOORD0;
                float  tangentW     : TEXCOORD1;
            };

            v2f vert(appdata input)
            {
                v2f o;
                LIL_VERTEX_POSITION_INPUTS(input.positionOS, vertexInput);
                o.positionCS    = vertexInput.positionCS;
                o.uv0 = input.uv0;
                o.tangentW = input.tangentOS.w;
                return o;
            }

            float4 frag(v2f input) : SV_Target
            {
                #if defined(_TRIMASK)
                    float4 col1 = LIL_SAMPLE_2D(_MainTex,sampler_MainTex,input.uv0);
                    float4 col2 = LIL_SAMPLE_2D(_Main2ndTex,sampler_Main2ndTex,input.uv0);
                    float4 col3 = LIL_SAMPLE_2D(_Main3rdTex,sampler_Main3rdTex,input.uv0);
                    float mat = lilGray(col1.rgb);
                    float rim = lilGray(col2.rgb);
                    float emi = lilGray(col3.rgb);
                    float4 col = float4(mat,rim,emi,1);
                #elif defined(_ALPHAMASK)
                    float4 col = LIL_SAMPLE_2D(_MainTex,sampler_MainTex,input.uv0);
                    float alphaMask = LIL_SAMPLE_2D(_AlphaMask,sampler_MainTex,input.uv0).r;
                    alphaMask = saturate(alphaMask * _AlphaMaskScale + _AlphaMaskValue);
                    col.a = _AlphaMaskMode == 1 ? alphaMask : col.a * alphaMask;
                #elif defined(_NORMAL_DXGL)
                    float4 col = LIL_SAMPLE_2D(_MainTex,sampler_MainTex,input.uv0);
                    col.g = 1.0 - col.g;
                #elif defined(_TEXTURE_PACKING)
                    float4 p1 = LIL_SAMPLE_2D(_PackingTexture1,sampler_linear_clamp,input.uv0);
                    float4 p2 = LIL_SAMPLE_2D(_PackingTexture2,sampler_linear_clamp,input.uv0);
                    float4 p3 = LIL_SAMPLE_2D(_PackingTexture3,sampler_linear_clamp,input.uv0);
                    float4 p4 = LIL_SAMPLE_2D(_PackingTexture4,sampler_linear_clamp,input.uv0);
                    float4 col = 1.0f;
                    if(_PackingChannel1 >= 4) {
                        col.r = dot(p1.rgb, 1.0/3.0);
                    } else {
                        col.r = p1[_PackingChannel1];
                    }
                    if(_PackingChannel2 >= 4) {
                        col.g = dot(p2.rgb, 1.0/3.0);
                    } else {
                        col.g = p1[_PackingChannel2];
                    }
                    if(_PackingChannel3 >= 4) {
                        col.b = dot(p3.rgb, 1.0/3.0);
                    } else {
                        col.b = p1[_PackingChannel3];
                    }
                    if(_PackingChannel4 >= 4) {
                        col.a = dot(p4.rgb, 1.0/3.0);
                    } else {
                        col.a = p1[_PackingChannel4];
                    }
                #else
                    // Main
                    float4 col = LIL_SAMPLE_2D(_MainTex,sampler_MainTex,input.uv0);
                    float3 baseColor = col.rgb;
                    float colorAdjustMask = LIL_SAMPLE_2D(_MainColorAdjustMask, sampler_MainTex, input.uv0).r;
                    col.rgb = lilToneCorrection(col.rgb, _MainTexHSVG);
                    #if defined(LIL_FEATURE_MAIN_GRADATION_MAP)
                        col.rgb = lilGradationMap(col.rgb, _MainGradationTex, _MainGradationStrength);
                    #endif
                    col.rgb = lerp(baseColor, col.rgb, colorAdjustMask);
                    col *= _Color;

                    bool isRightHand = input.tangentW > 0.0;

                    // 2nd
                    UNITY_BRANCH
                    if(_UseMain2ndTex)
                    {
                        _Color2nd *= LIL_GET_SUBTEX(_Main2ndTex,input.uv0);
                        col.rgb = lilBlendColor(col.rgb, _Color2nd.rgb, LIL_SAMPLE_2D(_Main2ndBlendMask,sampler_MainTex,input.uv0).r * _Color2nd.a, _Main2ndTexBlendMode);
                    }

                    // 3rd
                    UNITY_BRANCH
                    if(_UseMain3rdTex)
                    {
                        _Color3rd *= LIL_GET_SUBTEX(_Main3rdTex,input.uv0);
                        col.rgb = lilBlendColor(col.rgb, _Color3rd.rgb, LIL_SAMPLE_2D(_Main3rdBlendMask,sampler_MainTex,input.uv0).r * _Color3rd.a, _Main3rdTexBlendMode);
                    }
                #endif

                return col;
            }
            ENDHLSL
        }
    }
}

