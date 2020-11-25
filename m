Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23FA2C48A6
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Nov 2020 20:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgKYTmo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Nov 2020 14:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbgKYTmo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:42:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62914C0613D4
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Nov 2020 11:42:44 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i2so3078634wrs.4
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Nov 2020 11:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=MT4M9SX2NqdNuOObXhIV8Gtkw+yoDX+gRyJnh+feBwM=;
        b=O4Y4wkeEKuME+gZ9VWV45QeDl2jyUrvn+UnhOFvOCX3Rc/vuMopVXgRYH/nP225i3x
         45DaNhEZzCU6m09gcyUSQDVQEGUIHxBpGeqiIVpi9/9FDHzCPT8CesFQYe3azAXkXsYC
         61nBjRMLMJx0Ji5B3J2YfywLV0JhnSyPpQsu1xzclY8rWw08xzhdRqw8QRnafAuSHLSF
         nOPqbsbZ+iMD1lCN4OH8yawt8r6fbSHksHfbcmFfrt6qCo3y+aYSYFrXRsRzY53NxoV5
         ilYsHxFFV8soTdEnQpM236jTzuYCY/FwCvc4f0WnyTGLCyKdBD9vhKBu5ApypBt98q2c
         q11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=MT4M9SX2NqdNuOObXhIV8Gtkw+yoDX+gRyJnh+feBwM=;
        b=mv7ZguK/ZRdaCTz0FrWvoEWSf8WVsKDJkttmZqldr/NCNDkHjjo9WRLvVwuxEGoEQo
         W+RxLquNM0pA5EWNoC5ZzT9GfTbBGsKZfbTZutPI0VS4R7KPsExF18hB3Hm1QCmTghcx
         gt7fIpgtPP8T6I/GaMejPiSvEtRza77U7Ksh+/Eod4X+7gf+VsF6ZrSF/goe7W2Z/LMp
         Ddb9iEawU/NdIxCouZmG95WzdDvVsDIrW6ToN8VlMBjJ4gOxHgnKq3Fko9GuqeDUf9kD
         lFOT/4XyXpN+2APeXjDHX8I6+heZ27Wx0elm3cFwHmaGwlx2DkAKmZe25iOblEyyo54Q
         1X1Q==
X-Gm-Message-State: AOAM533iU0kE2JI53mMZRF92791Rf4To/7YOyAEhwx4v5UeucohzxdoN
        eyEYDL898yyTXPTECLYrD4Q=
X-Google-Smtp-Source: ABdhPJxPKvvKp90PbPmPSaivAiMpaAlRd7ZOxHI5mcPramAiqy8c+Ni55Mf8Yult0ngB8/e8zzuHSQ==
X-Received: by 2002:a05:6000:124b:: with SMTP id j11mr60503wrx.174.1606333363240;
        Wed, 25 Nov 2020 11:42:43 -0800 (PST)
Received: from [192.168.1.152] ([102.64.149.89])
        by smtp.gmail.com with ESMTPSA id u129sm5090970wme.9.2020.11.25.11.42.36
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 25 Nov 2020 11:42:42 -0800 (PST)
Message-ID: <5fbeb3b2.1c69fb81.a9b8d.bcd8@mx.google.com>
From:   "Dailborh R." <ritundailb333@gmail.com>
X-Google-Original-From: Dailborh R.
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Please reply to me
To:     Recipients <Dailborh@vger.kernel.org>
Date:   Wed, 25 Nov 2020 19:42:25 +0000
Reply-To: dailrrob.83@gmail.com
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

I'm Dailborh R. from US. I picked interest in you and I would like to know
more about you and establish relationship with you. i will wait for
your response. thank you.

