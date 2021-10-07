Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943D44253A6
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Oct 2021 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhJGNIf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 7 Oct 2021 09:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhJGNIe (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:08:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB4C061570
        for <netfilter-devel@vger.kernel.org>; Thu,  7 Oct 2021 06:06:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h3so5617675pgb.7
        for <netfilter-devel@vger.kernel.org>; Thu, 07 Oct 2021 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pxAJfWIgVd64n+QeFsmNwc6CX3KtWrCuEuUZH5Q9H00=;
        b=HAGR2faQgE5rggMhfoSU7MSEOZvDT3T+iXjOsPqHr8wR82LIoSFzsCMS/uUoNq9Uj7
         828K0vp3QYnHk6RGPKaezw8Tpxoid2lTkSIEI5ldH7cOm/qca16RPWS5ixyq/Qhw/CDF
         gPdpBb4R2s6E2HUbWqyHdGnhDFgFY8AHp0dgqiywJtuJ8tPPYknpmq1W2CFK1ayZ6pvS
         xLjKqSKjJl3PGR1yEPPJet2enm8UlpfDPS9OTwJ+LA9lAJqxJzFSqBU10nrlRb4GxH0F
         C/7Vfjsegp43gEuW9TVBe3x9vDzc3b5Jt7FwYsHNOwOgNcHUus7UVD+H2r3fIuVkNKJy
         8HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=pxAJfWIgVd64n+QeFsmNwc6CX3KtWrCuEuUZH5Q9H00=;
        b=lEXWrB9KBX9SAySJZHGYOkLvdCta2ndA2xm/epzrD2D6kvniOdIyzri+lG8ckCQbi/
         SfinzZ+pjSQ0XiVHUWmPHeI/vZ4V95TXmv6/YzBfHDAEhP7Ru8kqUwDJUybtLn60ByJt
         GGKWgguctNLWhYH3RqVWXMFAph6cTwF10e52A5fzhXHiVISGx/yZuMfxnQfFjh+DAur6
         hAoOrRPFTD2xg55aQH2KO1n28XFL7EOfW5i1+pkwKFnIdyaXohJDpiQlTylp4sdZWETj
         NAiok5CvbCbD1hjvZF4PT6bjhunx4jfx7C4pSBUEJjetFN8wxViimlxJug8tGm0XMVOH
         2NFQ==
X-Gm-Message-State: AOAM5325P5Dm9cXoUpjg+ZRtAAxPGTR2/MF5zxy9ZGPJcRIxaGYg7cfB
        KVo5uBgBe8+wX0mDDW9kHvx5WiGG8FH/uqg9mjw=
X-Google-Smtp-Source: ABdhPJzpb2zF8nkZjVIxxzHSyASlvUQzuHh/yNj6zEYUwaVCqqWyAqwLhg7Hjnn0utRffVtNGKcGDHnEr8vZid1p9c4=
X-Received: by 2002:a63:dc42:: with SMTP id f2mr3326945pgj.152.1633611999773;
 Thu, 07 Oct 2021 06:06:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:1891:b0:46b:b1a1:af94 with HTTP; Thu, 7 Oct 2021
 06:06:39 -0700 (PDT)
Reply-To: lydiawright836@gmail.com
From:   LYDIA WRIGHT <harrydav828@gmail.com>
Date:   Thu, 7 Oct 2021 16:06:39 +0300
Message-ID: <CAKKtfnJZnK+zGb-0KGi8Wpp99kcj_zbcdp_PdA0mDG3RF5Awzw@mail.gmail.com>
Subject: Hello friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Greetings dear,

My name is Lydia A. Wright, and I'm from Akron, Ohio. The U.S.A, This
message will most likely surprise you. I'm dying of cancer, which I
was diagnosed with around two years ago, and I'm recovering from a
stroke that has made walking difficult.

 Mr. L=C3=A9vi Wright, my husband, passed away in mid-March 2011 from a
heart attack. I'll be having surgery soon.  I only have a few years
left in this world, my late spouse has  $10.5 million as a family
valuable, which I intend to gift to charity.

For more information, please contact me at (lydiawright836@gmail.com)
. Thank you sincerely!

Mrs. Lydia A. Wright
Rosalind Ct, Akron, Ohio, U.S.A
