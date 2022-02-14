Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B464B510E
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Feb 2022 14:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353892AbiBNNF6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Feb 2022 08:05:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353894AbiBNNF5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:05:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347C74EF6A
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Feb 2022 05:05:50 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso11576467wme.5
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Feb 2022 05:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=B7DIruEwpY6LnJr5znqcsEC41//oZpAzNYRs8eA7tGs=;
        b=ijMvTzYBJQQxlNah1pBen5Jwpck0ZR4uDWEzR3jUx59SEtKDE0hpf4Je+4bdbWR3Yg
         iKGBQYD3wUjXvCP/Em7+UWZaITtk2WT0c2HKcnYFVJSYrWnKpzyu2mYCLCVq5F9Zci5I
         TM0S4tuyuMwJBgPdasKcBdnGOfNK8TrTpvsqlu0H/QGkMkUqQS4C67OnH8AX5v77Q53A
         iA8G8IcE5bDf/1KnTC04y6wJlWpz6ZjfNgixquRzZVfmXYGoB5zv9g0fWs3lki4pQqn4
         UdIyx0Uz3I6Q9/Wg6LTe6+vQuc8BZhtK2y2K4Dw1RPISkvuhBApTaNN1ydTsWKC2KGhj
         oL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=B7DIruEwpY6LnJr5znqcsEC41//oZpAzNYRs8eA7tGs=;
        b=0NVUcPM6zTj0DjU83IV8uMKUcPxTlc22mgA7r2MQWYpcitLX7egHqUe+ZUuvi2Y3ae
         6Q+jPIJB6W4P5a1DVAA0awXBsp03e519bzAi+JtOvr/GrqV/2mmMAdDnCuV9oHXgkHKr
         zmwIM2ySVBkkmDvlpgOTtLUfTMcmzFIcznykp5Iv1r0gyQwskJbvAKUGuFgfA/unbBRx
         nscyNIIr9CA9Si57ZZSIxuJa4uWp1L1f00GcvQtD4weUIJwicgOEv713VBU7pT+k/DuG
         ONLcX5LDzkBSXnavSkDuXWOGXgO2ik5uOA/ekYZv2602WzmLaG0hEhQGEEE2BZ6nsqxD
         0hZA==
X-Gm-Message-State: AOAM533Q4NbkIwZHTAG5QHOhOWOMu9XjqqH8I4DeBMFEtduFMXsMBU0j
        RkOXzOmvmWA1sDj0WZyHQhqJBfHpKO+cqRUdzLs=
X-Google-Smtp-Source: ABdhPJzEXdWzPUwGg7nnl5fhMUQbtLCo/TreCUPYS/ULatDSvsry/lfwT3nLFWMNVRZa50XlgyHetXM+sXcPyCiLGY8=
X-Received: by 2002:a05:600c:1c9e:: with SMTP id k30mr2825705wms.168.1644843948802;
 Mon, 14 Feb 2022 05:05:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:4485:0:0:0:0:0 with HTTP; Mon, 14 Feb 2022 05:05:48
 -0800 (PST)
Reply-To: asamera950@gmail.com
From:   Samera Ali <princesesther94@gmail.com>
Date:   Mon, 14 Feb 2022 05:05:48 -0800
Message-ID: <CAOWxp5PR5Uc2C5w4GrrM0OzCuZCEwiXSezZ=BSm+X4jiKLd=dA@mail.gmail.com>
Subject: Hello dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:336 listed in]
        [list.dnswl.org]
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0150]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [asamera950[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [princesesther94[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [princesesther94[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

-- 


Hey dear

Nice to meet you, Am Miss samera I found your email here in google
search and I picked interest to contact you. I've something

very important which I would like to discuss with you and I would
appreciate if you respond back to me through my email address as

to tell you more about me with my photos, my private email as
fellows??  [ asamera950@gmail.com ]

From, samera ali
