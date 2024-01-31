Return-Path: <SRS0=pMZs=57=smtp-tls-reporting.bounces.google.com=3Nd3cYxoKAIgz03q1xA-4y51-5x4-3q1035uzss00sxq.o0y@blogreen.org>
X-Original-To: romain@blogreen.org
Delivered-To: romain@blogreen.org
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::746; helo=mail-qk1-x746.google.com; envelope-from=3nd3cyxokaigz03q1xa-4y51-5x4-3q1035uzss00sxq.o0y@smtp-tls-reporting.bounces.google.com; receiver=<UNKNOWN> 
Authentication-Results: agrajag.blogreen.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b=duBHRVBz
Received: from mail-qk1-x746.google.com (mail-qk1-x746.google.com [IPv6:2607:f8b0:4864:20::746])
	by agrajag.blogreen.org (Postfix) with ESMTPS id D164715F4C
	for <romain@blogreen.org>; Fri,  3 Feb 2023 12:09:01 +0200 (EET)
Received: by mail-qk1-x746.google.com with SMTP id op32-20020a05620a536000b0072e2c4dea65so1203709qkn.12
        for <romain@blogreen.org>; Fri, 03 Feb 2023 02:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:message-id:tls-report-submitter:tls-report-domain
         :date:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P3dr5KOhwd2AJ0sfj6ZMODimxRVtg6zyfo3Q8GtNWb8=;
        b=duBHRVBzbQgbGZdO8TpTYp1beH8Tb2Hu5gInVQsqXRF0++5ADkekBnn3S+DV2rhQcv
         u4/mtpv3xquFxipkhel9hIEWLBI0fnY11g1FM5I1lpiYMxInYLG+Ct3VE1E0KyduAU9D
         LT3SE/InzJysfdLHFHsvIjasmeToF61p+rVKBjGJWrBxR7ucnm8W7NQYc2TceTurV8IG
         WoDCH1WqHmo4NXRjy2DShj+RSoLUhGclzBYN0HFFwLeRQ4fC1+7vGeuVZNjcPyxchQK1
         sxTr+vOdydu4JjuOFbQ+5cxgu3hUHduZfzpiuXcHxB3d2jbLggfUiJVMRbhQ5lhxgmB8
         MljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:tls-report-submitter:tls-report-domain
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3dr5KOhwd2AJ0sfj6ZMODimxRVtg6zyfo3Q8GtNWb8=;
        b=tzLuS3jWnIEurU1G8pRxoUxc2ahQmzSt+VYdLAonx+Spf8ITrmZ0Z/TLK0dQyNw/5p
         T1URZypWNyJZutonRLuiLIbthcR4JNdAgbY2Bttt3NSakCno4kdNnPknRH9ojFiK+u+a
         uzJU97gFpbWohuFCw6qIIDgR9oyIFn8+6XTpRQNZ8S6kwiPQukbhUCf5KXjioj9CAcAs
         E19NvM3HvYhfjo119mJjXdBl5W3M4zLXbZPjPbRoZ5DBZZ4aeJs47u+sesJL7n3vquxG
         EtuKQ7z/kuPaZmOpQulvdJC7MGqabOhyWbWacA6pX0JtSEECcbwaqAwws3m9wzfPeTnn
         Oq5g==
X-Gm-Message-State: AO0yUKXqRc58TMikXVsb9seCvXRCtvWBNo1qzAeidYanMkvN4wjC73Vy
	8E9opVSaAbV91DU8Jqd1hfBHq9C+EiD64EQKq4q4jqbCXw==
X-Google-Smtp-Source: AK7set9h6xWIMSb8SDyuUVbXsHyWC+AsDiH9oVDT46TiH1nQGkFzmIilj2uvd+AYx1Ga8qQeFnTqByAJiv61nnY90uf6zksFLiFTQ12Dt2o=
MIME-Version: 1.0
X-Received: by 2002:a05:620a:16b3:b0:6ec:5332:6ebd with SMTP id
 s19-20020a05620a16b300b006ec53326ebdmr769788qkj.0.1675418933805; Fri, 03 Feb
 2023 02:08:53 -0800 (PST)
Date: Fri, 03 Feb 2023 02:08:53 -0800
TLS-Report-Domain: blogreen.org
TLS-Report-Submitter: google.com
Message-ID: <00000000000066453b05f3c8de51@google.com>
Subject: Report Domain: blogreen.org Submitter: google.com Report-ID: <2023.02.02T00.00.00Z+blogreen.org@google.com>
From: noreply-smtp-tls-reporting@google.com
To: romain@blogreen.org
Content-Type: multipart/report; boundary="00000000000066452705f3c8de50"; report-type=tlsrpt
X-Spam-Status: No, score=-7.6 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-14) on agrajag.blogreen.org
Status: RO
Content-Length: 865
Lines: 20

--00000000000066452705f3c8de50
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

This is an aggregate TLS report from google.com

--00000000000066452705f3c8de50
Content-Type: application/tlsrpt+gzip; 
	name="google.com!blogreen.org!1675296000!1675382399!001.json.gz"
Content-Disposition: attachment; 
	filename="google.com!blogreen.org!1675296000!1675382399!001.json.gz"
Content-Transfer-Encoding: base64

H4sIAAAAAAAAAHWRwW7DIAyGXyXiXCKabtPGabdp5/bUqaoYoQwp4Ag7Vboq7z6TbjtEqmQJgz//
v4GrgOxNCt+GAiSZTHRCizcA37nqPdlarERryMlskufSVSCZTLKcUZjhRjUbqRqOnVJ6jj13udTe
oZqNfnzh2ItpJSwkMpZkSCdgDCP1kjqU2fWQKST/6udhaguRVW/HMrR3jI+fHfjsXKr5Xsz30AUb
HAr9cb1tLuUSt0zSpS+zIeEfepFImV2ZF2eXkR9FV9vd9rxmIkLrdEUOy1xlP+oqjvXCMprxaDyD
z08PSonDv3IL0YTEfsuGUX4BUrFcqh34hXCI0eR5bAIyncTBWod4GjjltfybhSGxwHr1i5xM6Ibs
lnU1TYfpB3eSWuLzAQAA
--00000000000066452705f3c8de50--


