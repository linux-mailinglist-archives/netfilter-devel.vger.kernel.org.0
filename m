Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06552BC9C3
	for <lists+netfilter-devel@lfdr.de>; Sun, 22 Nov 2020 22:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKVVuA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 22 Nov 2020 16:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKVVuA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:50:00 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F93C0613CF;
        Sun, 22 Nov 2020 13:49:58 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lv15so14755945ejb.12;
        Sun, 22 Nov 2020 13:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=gif2YsUEzlKUeKs+7l6cfW2WmqaZyHxAHI7qpQ7HjC2yRUKMDDzuJlQwUKv/p1qZag
         bsq14HMKp8vIot60wla2m8AXCDDX5lLyiFfsXWmzmEtjKlovcfOMEQb3HI7VgxNT7y9r
         83Lx2JP1tuGHpErczCo3vb1EinRrigpBGD/jBrkGtZbJjMaTVykST1JLMOuIHI9nyyCc
         4xubODBxmdbm8osEnV8iwaRnc0UiIGEOXJHRYT0T78wXcV2JV2Pw3lGKFxq32K6CfoJX
         zikry6IhC7Lxm+AelSy0RrK0h+w04V7hpz3J0rzJA93zBGlDGbOhNWPdrRd8CbEbReyJ
         sL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=holMzMixu6L4mPkY4KLX0AXrH3B7KLU6Q1+gVZ1hbDo=;
        b=IPKT7fMcHLAoAKcmrmbRTaXPJ/lb3C2a5HwFi22FKrC3q9sXq1CZQuuUnwwj202wL9
         L6BYCZMINqcbN88tN66qgGNhwhJKXg2AgLY/QrfFrbLfhHlvTLAwM0GpEl3cY7IXmc5V
         HvWz5VFcnbBAX4goIv6IPHJIspFaRwr0IZaO1ay0vQqDQ3qXpDlXECnlH4RlXHPSyVl5
         3bZPvr9e28YSIE6IWMdwJtHTvNoAlLwfcNxEw3oNVXogy/X/d7tm18fmdbM0P2g0p6FU
         9Fo/9O2wASpPP9VjP2LzghRn4pY5gA6pU95X/9wVKOVsi/QuYyLPWHtVCx+PkC+aBjNi
         bidw==
X-Gm-Message-State: AOAM532purNYi2UUm9GNBvZEI12gusfh+ZJALAJ1MUNImNFCzXQH6yWN
        ifQKBtKp5k4FCaPheXGdNrI=
X-Google-Smtp-Source: ABdhPJy+0k3yEDYZ7eW0JuP98sfBEuWqIZvqB8+PZNbYHye7hHKo/pBe7JBENH/ZpOOG+QzV6iff7A==
X-Received: by 2002:a17:906:a3d2:: with SMTP id ca18mr3259272ejb.107.1606081797557;
        Sun, 22 Nov 2020 13:49:57 -0800 (PST)
Received: from [192.168.43.48] ([197.210.35.67])
        by smtp.gmail.com with ESMTPSA id e17sm4016232edc.45.2020.11.22.13.49.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Nov 2020 13:49:57 -0800 (PST)
Message-ID: <5fbadd05.1c69fb81.8dfc7.11c8@mx.google.com>
Sender: Baniko Diallo <banidiallo23@gmail.com>
From:   Adelina Zeuki <adelinazeuki@gmail.com>
X-Google-Original-From: "Adelina Zeuki" <  adelinazeuki@gmail.comm >
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello !!
To:     Recipients <adelinazeuki@gmail.comm>
Date:   Sun, 22 Nov 2020 21:49:46 +0000
Reply-To: adelinazeuki@gmail.com
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi dear,

Can i talk with you ?
