From SRS0=XBdr=6A=google.com=noreply-dmarc-support@example.com Sat Feb  4 13:46:24 2023
>From SRS0=XBdr=6A=google.com=noreply-dmarc-support@example.com  Sat Feb  4 13:46:24 2023
Return-Path: <SRS0=XBdr=6A=google.com=noreply-dmarc-support@example.com>
X-Original-To: romain@blogreen.org
Delivered-To: romain@blogreen.org
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=146.59.199.37; helo=smtp.example.com; envelope-from=srs0=xbdr=6a=google.com=noreply-dmarc-support@example.com; receiver=<UNKNOWN> 
Authentication-Results: agrajag.blogreen.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b=R7VJPqxb
Received: from smtp.example.com (smtp.example.com [146.59.199.37])
	by agrajag.blogreen.org (Postfix) with ESMTP id 04EED321EA
	for <romain@blogreen.org>; Sat,  4 Feb 2023 13:46:21 +0200 (EET)
Received: by smtp.example.com (Postfix)
	id 81C76C2AC5; Sat,  4 Feb 2023 12:46:19 +0100 (CET)
Delivered-To: romain@localhost
Received: from vps-0ecac6e3 (localhost [127.0.0.1])
	by smtp.example.com (Postfix) with ESMTP id 707E8C2C53
	for <romain@localhost>; Sat,  4 Feb 2023 12:46:19 +0100 (CET)
X-Original-To: sysadmins@example.com
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::849; helo=mail-qt1-x849.google.com; envelope-from=noreply-dmarc-support@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp.example.com;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=R7VJPqxb;
	dkim-atps=neutral
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by smtp.example.com (Postfix) with ESMTPS id 2E15DC2AC5
	for <sysadmins@example.com>; Sat,  4 Feb 2023 12:46:18 +0100 (CET)
Received: by mail-qt1-x849.google.com with SMTP id v8-20020a05622a144800b003ba0dc5d798so1750432qtx.22
        for <sysadmins@example.com>; Sat, 04 Feb 2023 03:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:content-disposition:to:from:subject
         :message-id:date:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VG8ZDTg6ui/qhoN9Q4nkvTBUBi/CMz8FmHjQmPV++1I=;
        b=R7VJPqxbhHwPcpdWTfk9f7S6cKWf9ls7eVHs0F/6HfkRF7iihRg7JobA8jRwtQ1afv
         4CJv1WCj3kgo3Wi7HGTY8LT1Cr2l64KeJr81KUCbKtb08FH7PU3Vr8peUSW8N9f/w6Pm
         0t2mqjd+NRyhP0Xm2yUTYUXYcJj9OIIh51E+S6qQILtUCY8FIDpKg5t47ATAHwq2zQ5M
         hHlWUlHNcB0mKbXawY2hHcPIfAm9hYnmYekpOtHma1alZ3hkHjXrZju0k8Hfg/BnRAAQ
         fTvs7wPqIBQvpODWHGCS2eNVkFiI3HZOmnblzlsaXuXLdcrHoFtJA3qizQ7YR/P0CRNm
         MZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:to:from:subject
         :message-id:date:mime-version:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VG8ZDTg6ui/qhoN9Q4nkvTBUBi/CMz8FmHjQmPV++1I=;
        b=edB2AvGo4QrFlUgmnzGCSULCPWA3qgoK9t4cL8I6uMzFnn6WDerPSY+8f/iA6xDUVB
         kwxQi3hZYgAn7C30T1pGGBXihDrha6zmLlgY91pwHzKtv68/JzcOpNJHCc3uT28JVpxN
         HTq6xaZr+ygpUoLbcS7HgYt2TSBCNcKxOYkx+ecXC23WHbJlv/eHY5jrG+kMf2Rfeje8
         0NfgKsl+sBpCnuXCYy0BPECuXOAoEYRziyaxPVqigaJEV5zCjuOGGOCpA43Co9EezVEd
         AsWwSyur/8IyrgTiPO9GmPe/gd8lXVuE2L6AcNQDxgyuhBTuoXQAHDYm9N8jeBNoPwYI
         YACw==
X-Gm-Message-State: AO0yUKWj6fCr/fi3btiLI8FM3JdO62I0oBoiYxKhD+p24G61+OGWI9UM
	3iFEsb8dExejRUD1RHP6sg==
X-Google-Smtp-Source: AK7set89WQa6lwzi7fNzFbvZzyWpP8utjsHYqG+L6+mWaBhJ8it2szCrZB+7Lu9wD5quU5bRODAQyX62kAEs1w==
MIME-Version: 1.0
X-Received: by 2002:a05:622a:1986:b0:3b8:4cba:e26f with SMTP id
 u6-20020a05622a198600b003b84cbae26fmr1088025qtc.311.1675511177705; Sat, 04
 Feb 2023 03:46:17 -0800 (PST)
Date: Fri, 03 Feb 2023 15:59:59 -0800
Message-ID: <3520290261551105475@google.com>
Subject: Report domain: example.com Submitter: google.com Report-ID: 3520290261551105475
From: noreply-dmarc-support@google.com
To: sysadmins@example.com
Content-Type: application/zip; 
	name="google.com!example.com!1705363200!1705449599.zip"
Content-Disposition: attachment; 
	filename="google.com!example.com!1705363200!1705449599.zip"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-6.2 required=5.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-14) on agrajag.blogreen.org
Status: RO
Content-Length: 1147
Lines: 14

UEsDBBQAAAAIACdDM1g6wl639QEAAL8EAAAwABwAZ29vZ2xlLmNvbSFleGFtcGxlLmNvbSExNzA1
MzYzMjAwITE3MDU0NDk1OTkueG1sVVQJAAOKvqplir6qZXV4CwABBOkDAAAE6QMAAK1Uy3LjIBC8
5ytcvttIsuS1VYTklC/YPaswjGQ2ElCAEufvFwJ6xNmqvezJTM9Mz3SDjJ9uQ795A2OFko/bfJ9t
NyCZ4kJ2j9tfP192p+3miTzgFoBfKHslD5sNNqCVcc0AjnLqaMA8qkzXSDoA6ZTqetgzNWA0g7EG
Bip6IpVn6D92fKCG7eyoA93zui3WpZ6bM7RhSjrKXCNkq8jVOW1rhFLrfmlFFFFp38Ggojweq1Pm
ub73R+IkQ3CSF9mpOObFIa/K4lRl1RmjJRurvVJoDJVd0uKhC3RCkvxHVh2OhyLzsyIy5UHyz2xZ
nquzpwxxJENf2eZpa0uxVr1gH40eL72wV5gXUd4cSeBGBz35lbBYQPmrGIjFKB4SaHX7iYXfCGl/
ERIw0im2mhj4DcxhZCdMM0fyoCwcIiSXMqnj9n/b1NvLlJmWNup9tsWq0TBohCbes7wuc57Vh6ys
fVTXrDrnfv5cMjUxNUq/CkbxMMFpMrzRfvSW8ikRfBJWKyucf9lJ6BpZ1QWTNLXenMWvZEibErNp
K7V3M/0dThqx4CCdaIX/rua2K1AOpmmNGr7e3TqRmL71Yzq6a2PAjr1bKO/W/dfDSI8+cCRZKVgp
ht5frDIkfH9e9hTO2tcj8cqV/zB+5bJ/pnd6Q3F8Thgt/0V/AFBLAQIeAxQAAAAIACdDM1g6wl63
9QEAAL8EAAAwABgAAAAAAAEAAACkgQAAAABnb29nbGUuY29tIWV4YW1wbGUuY29tITE3MDUzNjMy
MDAhMTcwNTQ0OTU5OS54bWxVVAUAA4q+qmV1eAsAAQTpAwAABOkDAABQSwUGAAAAAAEAAQB2AAAA
XwIAAAAA

