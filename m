Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB96C6D7AB9
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Apr 2023 13:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbjDELJE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Apr 2023 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbjDELJB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:09:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72F55BF
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Apr 2023 04:09:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id eg48so139980221edb.13
        for <netfilter-devel@vger.kernel.org>; Wed, 05 Apr 2023 04:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680692938;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2eIUIgQam+Znm92t75ub3SSql/5kD/CSnGjaZOIeRE=;
        b=L/13YJk8zDDShmILFF5HCSLOIj85oBHvmgOWPTKG/boHTKE281PrMgzslGyVCu/B38
         EXIGhHK2+mAi3IIeM/ZEB6n17GSPu1jHHkl7UFXKea8XXqUGQXZjt06uj3W7Y8cb1HBM
         JKHXXUl0fZuzQPz0FNickmWMu9m32DYYz2mPlrUGvzdGT6ZO9xGNF1RgcYUS1VQByW3b
         2wV8H407mi9+8oBwIoDt1XWfoGuYjBC88i3dYnhdkYwR/rjp0n1gVkB5QmbSnRySArLo
         6Q8N+JZN16mAhWJfIfQmB4o9ReZXA9GFSqLoZrmSo/toQ86Mt54U3HZsWpUddgnY6P8G
         R+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680692938;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2eIUIgQam+Znm92t75ub3SSql/5kD/CSnGjaZOIeRE=;
        b=b/HQg7PzasCDOb+a8ymxkA+49G23xH8X79/dHuLiIIK/mr7x8E5V0QGTpjSqaENRpD
         3pQY+KDFMQGONPgNRrZbUod2jSPQlheNWC0/24f4JowlcKubudYONFIdJECX+8LZyvIN
         CcJRyiLqlq0RoK1mxvMSIaEIzmd8E2flcIZBCVMrINOE1FHJg5gOlIA1f6v76Wxuk+U3
         x3yLzFh+qesGRnFOCE0khrNx+gFt+SUcuo6ijSI7i682QJR4dpeuNRfP2D1YgmGEsawu
         rC2k9l6DwEYY/SPoFBvRUUKmFkZq2W+pSxSLHBzjFZX6BLboyecLJ+zLijROsmv81LAM
         LdkQ==
X-Gm-Message-State: AAQBX9dU9ZKaJqihP3FUGzgYG9pUHpyyjB/VBPOtgQ+H3nDCc7SiNvKu
        3inJ1Df/vqWqCM2X+583vN6P576dRDBvHi8CQ9E=
X-Google-Smtp-Source: AKy350Z2382d6v0HigF6ZLUDjMos/FXZAZsE2i4Yn8we0J66WSSl/h01DlvIzThsQxxUN3GrMHuwp7SCE8cw/WPkXfY=
X-Received: by 2002:a17:906:7c51:b0:932:a33a:3754 with SMTP id
 g17-20020a1709067c5100b00932a33a3754mr1391710ejp.14.1680692938659; Wed, 05
 Apr 2023 04:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:3ca:b0:1af:aa1a:adb3 with HTTP; Wed, 5 Apr 2023
 04:08:58 -0700 (PDT)
Reply-To: tamimbinhamadalthani00@gmail.com
From:   Tamim Mohammed Taher <agnieszka66books@gmail.com>
Date:   Wed, 5 Apr 2023 04:08:58 -0700
Message-ID: <CAEbk9CyJB3kG3R10mVJFegSpbqT8HdP_cEFyTmmAxv4dbg-oZw@mail.gmail.com>
Subject: RE:Saudi Arabia-Inquiry about your products.!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=DEAR_SOMETHING,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:535 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [agnieszka66books[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [tamimbinhamadalthani00[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.7 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear Sir/Madam,



Can you supply your products to  the government of (Saudi Arabia). We
buy in larger quantity if your company can supply please reply with
your products detail for more information.

Looking forward to hearing from you.

Thanks and Regards

 Mr.Tamim Mohammed Taher

Email:tamimbinhamadalthani00@gmail.com
