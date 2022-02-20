Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBC84BCF9B
	for <lists+netfilter-devel@lfdr.de>; Sun, 20 Feb 2022 16:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244231AbiBTPrg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 20 Feb 2022 10:47:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiBTPrg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:47:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630104614A
        for <netfilter-devel@vger.kernel.org>; Sun, 20 Feb 2022 07:47:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m3so18524833eda.10
        for <netfilter-devel@vger.kernel.org>; Sun, 20 Feb 2022 07:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ymEpgIXl54yuSlZg88NLeYK1RJf0YDtYgXWD/9J1GQ0=;
        b=BH1U/LOKMPUv+nd6x4x34GdR6o4d4iBacQ787GaNHnf6vNx/SP+64cxyBXH9UZcLj/
         Hje1N9cY/gMnwyJVjFdTZKD6Z8XPkRQxuErf/XPjej8bGUqauW4vd5YL5ZaKR//G43GC
         amu7QvUO9oS7sfFuAIxGiBrGIveI3z5B96dFlnNewcFFC3y1fPRQHFf28c2F2BwZuI5r
         gR+X/xluV/0BPyD+je0HlzE7RpWLUjUzOEYcyfS5+jzL2yfa3Ul33pOvGsaLggCW6s6h
         oScm2xbpYX4BF+I22cB8rq10aawat8OY9DPpG+FnMEH69i7TqUD3TBcL8KVxKHC0WHXg
         vULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ymEpgIXl54yuSlZg88NLeYK1RJf0YDtYgXWD/9J1GQ0=;
        b=Mxwft+OPW7XjqK6sH9OiUboc3ctwvhFXA00DiCnaSduFy1ezG/VBK0ZXe8qC9O15OO
         WAhDhzAXKBhlmkkzgFbsD30lQ4naOB5IfmFF0xai5+TI1E2N4Cbuu76A53dEZOSMV+dE
         hwHVVKOC45RfiQh02TToOfNNczz1IXz7nT+IeNQZTY8rAQ3B+GgyvrGLldvSXwi36Imi
         GTm0f18h1hJqPLDL0AJQwvtNzoRWlgz+XeRafKel6yeTvXKUkBuCtCod1dCVWQw47Vdz
         NwVD7IkOVLhmzO+uW2Z1syywQRoG03Dp2Rcyn9RJDIbOEG9LhI9z0eJyR3ad+waLyl6k
         CJlA==
X-Gm-Message-State: AOAM532roa++FMyuCG1vBGH0dQzmpBVbtQW83umLF9WGJzscWhamK/LR
        UbjW+SGLKTEH6zLcjfCVPdZv1mw3ll4QCK6to5g=
X-Google-Smtp-Source: ABdhPJw8ZJhY/kVcFchs7dUtktlFgvpEkXNrPFby/a4LOApXaZl8XaXKh2SidvFcd6ZIdiO+OYZ8y31dj8VcrvqrLws=
X-Received: by 2002:a05:6402:4245:b0:410:ee7d:8f0b with SMTP id
 g5-20020a056402424500b00410ee7d8f0bmr17414544edb.295.1645372032952; Sun, 20
 Feb 2022 07:47:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:38c1:0:0:0:0:0 with HTTP; Sun, 20 Feb 2022 07:47:12
 -0800 (PST)
Reply-To: fatibaro01@yahoo.com
From:   Fatimah Baro <imanosose@gmail.com>
Date:   Sun, 20 Feb 2022 16:47:12 +0100
Message-ID: <CAFEyOE7-qdYqVbyiqaWGnoopOjGnDhopvJU26gRgorooitZWZA@mail.gmail.com>
Subject: Business invitation
To:     imanosose <imanosose@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Greetings from Burkina Faso,
Please pardon me if my request offend your person; I need you to stand
as my foreign partner for investment in your country. Please reply
immediately if you are interested, so that I can give you more
information.
Fatimah Baro
