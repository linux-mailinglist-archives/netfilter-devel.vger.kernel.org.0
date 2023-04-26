Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526B6EFB5A
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Apr 2023 21:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjDZTu7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Apr 2023 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjDZTu4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:50:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8611410F
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Apr 2023 12:50:55 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id 6a1803df08f44-5ef673a49e2so72507946d6.3
        for <netfilter-devel@vger.kernel.org>; Wed, 26 Apr 2023 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682538654; x=1685130654;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=mYuDoZyMYzkvLrBZXjlBwAJCklB5D2XggogsoijTqvd6+xRox8Ew0kapzqpY+w6geK
         U3x5OUXZ5dvkFPr8bpAbYXe7DA67zlTJZE0KMce4h+iIlZlwYSf2ikrPiT/wo5OJmloL
         CctOF+1rptHVYbQfWIl/VyCUDaRo+4HPGsmQSYqL38K5hffQoNjPTGHYFdrPKzR6tAt2
         Bz0b1uYHSesoHNbUGW4OyaK+vHkgFbQ0d6xdYAZiTb4vndPGqUHhChDPZynWIdiZADo4
         YyPlIRa4L1yoVcUeUuUKHwoy8nGXERLYGjtWUD/cJmxLpHnizm0l8vVI5mEJ1MAE1+Tl
         85Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682538654; x=1685130654;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL3yT3Q33W5/BCQtgOVvz2cK4S2v0dqNTi6RS5aes9g=;
        b=BNw5N7nuqLbhd4oa0PE8MM0tmuI2pOQVvNRhFWL0kBBSlZthIxG4sOQ4jTZlqHPdwr
         2fDgVF8Swu5gjBkj9Qpg8EQL6JkgCJLa25vo//olts3x0pa30k1iYH9vYZnbd/tLJrq5
         5IT4vkEKLYoIXclxlcTY62WhgBH8hOKXNp8Mc+90W7nsB6Lni5w42ounElPdtoLsKiC4
         zijOjeKO6Du0TrQFuCgfmLcyYtY4pDgG4++u0NlukIakS6zRT9IKCnmras65RUvKKVbQ
         UAAThao1atDePpZncdtkPf1SOUMJb7t9OObmSVB2qBpmpW0lXywKPUADpDYcIw1OrOJo
         48ug==
X-Gm-Message-State: AAQBX9flVBxGGr/gUW+sYW7XEC3s59A4nxn+OMt/5cxIYHwCFcDtgHb1
        e5Ob8whYnIipauNAbl4xwpAhoOIoOECQvBC4z+4=
X-Google-Smtp-Source: AKy350ZwD3oftIWjUYWUlXEq9ok85aKlxRqWoPOzDgfcbMgEIGfN87d5kWF57NqjiRzEqdFmb9BHRVw86REykj8KHTA=
X-Received: by 2002:a05:6214:d61:b0:5f1:683e:9bd6 with SMTP id
 1-20020a0562140d6100b005f1683e9bd6mr42147709qvs.9.1682538654732; Wed, 26 Apr
 2023 12:50:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:da90:0:b0:5ea:ecc1:879c with HTTP; Wed, 26 Apr 2023
 12:50:54 -0700 (PDT)
Reply-To: klassoumark@gmail.com
From:   Mark Klassou <yentrhdghi@gmail.com>
Date:   Wed, 26 Apr 2023 19:50:54 +0000
Message-ID: <CAGA=xqvhebkE7d=VtcM9tB7tGj73+BVczD5s-a3WPtFynTOVvg@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Good Morning,

I was only wondering if you got my previous email? I have been trying
to reach you by email. Kindly get back to me swiftly, it is very
important.

Yours faithfully
Mark Klassou.
