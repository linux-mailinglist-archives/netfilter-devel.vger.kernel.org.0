Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC76CBB93
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Mar 2023 11:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC1J4Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Mar 2023 05:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC1J4P (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:56:15 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73272683
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Mar 2023 02:56:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id n14so11311104qta.10
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Mar 2023 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679997372;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXfaiVEaS7XgCqm5+wRW8Wdj+DYINCUUAzdNfbuxeug=;
        b=oNpRRMCj1Ys1IpK5a22wzMpiU0aH0umsZ6l7wLDgCJ3/KFPwMnMdKazmDxuj3XQ8yh
         ON05pEm312fdyl5FkYFzuhNAs7MxdFXR0NSl6ImFsyVxJtsao1AREtirfq/ceqr7iP/r
         YnQcbKVkl4JCsLNKUqx9hw2zOLNVCT1tFYY2KxHnTjFh0HF8EH2jn8JY7f+1oNZiGp/r
         ScPe5JyM7JAiRoUcWLrkfkiFTxhuyw8IMKESp6AnhSqXjwq9tT3AOsNspDKcf70sYsBn
         iU4ViJnsmC+II11PFBEdUPSaFwxgep/quBA5aDnD+SXElJ+pPTZ3JjS2G7dAPDXWbpAm
         z8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997372;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXfaiVEaS7XgCqm5+wRW8Wdj+DYINCUUAzdNfbuxeug=;
        b=2RDAYasT/UB2mnqiwG22tQlwufjCMIXFNQRWeNlZbITsMtDKz6dDLQwwcOySiTWJGX
         T4PgGvgtCcBWFdYijZ4kx1oHd3c2Xi9f7T/l5xkejcscwIqfHvTjhS7WjCDngERWM5X7
         ko5aTtvBHJQ3R5kRFYK3QD0prCZr9as89ZkO5FS2kmS+Ph57c1yOnhVqPNPBnuGXHrUH
         FrcS0sclGXsvHkXl3fX05RPNpOEj+6yFpwYANc7ajAxf7VOsMig5iVYu4GsFszVhR+vN
         cyENmuWQBdX/yYV3nGmNCmQZz4EnZcvR+fqYsjLNZqERkkEPMKsvIiHW1fVEfKeEvqnp
         rBPQ==
X-Gm-Message-State: AO0yUKXkhHB+45AkCxNBX9tQr9oYiCLzk8XoLPOFO3PsCsqv5B7ZXx0R
        WT4fC/rAXpV67Pu9JeHbxeltKufNF4KlUcoZjQk=
X-Google-Smtp-Source: AK7set95v8Ofqkc1geuyI9y7sn7ZY7YoaNPmMZfK37EwA7cmfge23sx3bxXPeb4oaZ0EsDyOdIoHTyQdAVPedguPGGs=
X-Received: by 2002:a05:622a:1a0d:b0:3d7:9d03:75ae with SMTP id
 f13-20020a05622a1a0d00b003d79d0375aemr5661952qtb.10.1679997372038; Tue, 28
 Mar 2023 02:56:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:e4cf:0:b0:5dd:d6fd:2925 with HTTP; Tue, 28 Mar 2023
 02:56:11 -0700 (PDT)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <beattykate.01@gmail.com>
Date:   Tue, 28 Mar 2023 02:56:11 -0700
Message-ID: <CA+AyO7esQY5EN6kTOhPTz7ZfnKy7eG0zPjFuPbu9qJaY0EROig@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:830 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [beattykate.01[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [beattykate.01[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 Hello Dear

My name is Hinda Itno Deby Please I want us to discuss Urgent Business
Proposal, if you are interested kindly reply to me so i can give you
all the details.

Thanks and God Bless You.

Ms Hinda Itno Deby
