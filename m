Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3C50475F
	for <lists+netfilter-devel@lfdr.de>; Sun, 17 Apr 2022 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiDQJZh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 17 Apr 2022 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiDQJZh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 17 Apr 2022 05:25:37 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471537A0A
        for <netfilter-devel@vger.kernel.org>; Sun, 17 Apr 2022 02:23:02 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id f17so21223778ybj.10
        for <netfilter-devel@vger.kernel.org>; Sun, 17 Apr 2022 02:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=z+v8ugHyK4Bi1bsAOtuex5rzJWIULuLfF++ZnJg6JJs=;
        b=KQMz616qeW4GpZdTyzDWnyHL8Lmr156GXrfI/4tX/KD/IVbbaOPNqlSAaPA87K9baQ
         vQqzIL4EVXC4sHwwQfiyfinMlFZTwB/+uuvCb+INH39JymTmiLGZJFyij65EFrZUChih
         vOK3qcrJAdxjKXokgxETedJzIvsNApl2wkMXqlB3reu3QrOBdT0zTOEb2PEPD0l1gKsg
         gbvcTG5yH2R2GOyKL8we96d5EmnhQ50F+oUix2D6kq1odq3eyyd8UFgmw+1nCyLVhYpv
         MjqWo0Y8ytD+WIakoUW/iBc5tfvcd7xGeEuonpC/WwO9TThGb9TvbjgC4HJpC5mlz8ua
         VFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=z+v8ugHyK4Bi1bsAOtuex5rzJWIULuLfF++ZnJg6JJs=;
        b=Z2GFUpQWhTItamnwUnUnWYUkY13xkmqCoWM7tBfZDgzS1tfBMHGXiS+/IpMfWJHQT0
         zU9hbZ0GnogSDUcr8lMwGPEaBZbJaJfxvWC0i9PnrWSasrjNPL1nm6kHKz1dra0CgRCc
         wBWYVtsdj28pHGyIOXpAOiwGnMQ8hxIWK1tfDnk85UINyFAzsiJrLwEudA5sfZq4Piqg
         IUrWw9OhqUczS3I32DuZi42OgvlPgq1Pns8vt81nP4yHDfXdeIX4/ixsi5Hq9wXMLis3
         CaneX0Tq6BAnGqyHPdxa/xFux+Sh0ow0xc/PgGsk+H/AtSwtKI3i1GJc9NBMZm5mWOka
         fgqQ==
X-Gm-Message-State: AOAM531NrPi29VR8cnDMSgCO9mET0yQ3MTT+Arpd1+wgl4XoaDgHIXr2
        7f6LdpptunpjzVoGdGHIfP3fF+T0XY2euIUco5k=
X-Google-Smtp-Source: ABdhPJzTavI6+zQtOWF8nFsMOWVsEZXc9GBZGd0NBuwoWNaGgKgS5DorxaGS1/3QGv9Sfqk8vB7qPDYHp1iH/FwJIWQ=
X-Received: by 2002:a25:b94a:0:b0:644:db14:ff10 with SMTP id
 s10-20020a25b94a000000b00644db14ff10mr2523978ybm.648.1650187381848; Sun, 17
 Apr 2022 02:23:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:b986:b0:a4:b698:78d9 with HTTP; Sun, 17 Apr 2022
 02:23:01 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <markpeterdavid@gmail.com>
Date:   Sun, 17 Apr 2022 02:23:01 -0700
Message-ID: <CAC_St2-a=SrkznpJpu4oxMkC+Xy8X+VhY8FSPMBXHp5=5EQ2ow@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b42 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [markpeterdavid[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark
