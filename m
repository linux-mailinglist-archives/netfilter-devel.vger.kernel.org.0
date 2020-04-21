Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B74A1B203F
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2020 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDUHsP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Apr 2020 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgDUHsO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:48:14 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBCBC061A0F
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Apr 2020 00:48:14 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x10so11320810oie.1
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Apr 2020 00:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=f1JfsNRiU9CPiPWIvBjcsKVKQf1l0VHF1PLTYDvT8K8=;
        b=bfJHDU2SMc7F/0z1WBZfojIMwc5cVAZHcfPuNRRzHemYESwEcLJpWZziIV5F9WZgMV
         IlbhjLltzHgbc7KFA98VaDDu7L4TqFYzsuKdhQYIAJJFTlT9Jn6Wqq9pV1qn69osSgNI
         mwVmco17L9PE/GSGV6hgRZdTPd486vEFCLlxs6BwUPXmtMBoxRc+ECVU8fFq9x4Zx9dN
         jty/7qMurh+qBEL1bAAqDhPVfg3UZp+N2ymbj8rbpo3ajgXj1UvjwSkT3g/tOyoTrwzI
         njf082d7BdLaeWoYCha+0aeCeW4rBKjORenuLp7ak2yYdShvqQ0/eHfDN8EJvCxDLmpY
         LEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=f1JfsNRiU9CPiPWIvBjcsKVKQf1l0VHF1PLTYDvT8K8=;
        b=Qldzg+k+Ap+abQEdNnl4LLthydGqirzc7DU3EQATiYAtOhJyUZwook/Oh9k80JawH9
         imWTV8fIq8TG7K3jrOY1WrMIT/UVKWH5OeAgnyL4ldcepo/7HG41wxKhRS9GSyZfG3az
         bt0JgK76TMqHY7u6HVcb4MhdE8dGr4PllHkC7Hx9rGwh2aGosyoMaYSH2mvsKZyJsb7W
         1dGhzeezs76E1pG70qHbkBjeLo1NT0DTUpWsk12pUpe0WOLjPnRknahX2v7/GXy+SbSM
         2orKU6E0x3UCmA1Y3/CLgoO/dprcBFmfRKcif0JyxiN0mZf2AP3OPg0NIlka0HvL5one
         klZA==
X-Gm-Message-State: AGi0PuaoDUENDfkQqNYNYAORLBijeJtKcmvGOCsS7htQyUDbRLMC6wFn
        pZYUPglwxRNkm1hQ352sC9+Eh46GU5tPuA5zB6A=
X-Google-Smtp-Source: APiQypJuqHx/6KV9h0zsrPwyt3nxB8W5DoNjbp6ZDnn+kG2ZbCslFULGS5ZUJwDdK5m1WS3ox82+vchHRp5U4mD/Ng8=
X-Received: by 2002:aca:4a4c:: with SMTP id x73mr2339700oia.162.1587455294017;
 Tue, 21 Apr 2020 00:48:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:5b0:0:0:0:0:0 with HTTP; Tue, 21 Apr 2020 00:48:13 -0700 (PDT)
Reply-To: sulembello879@gmail.com
From:   Mr Suleman Bello <bmrsuleman@gmail.com>
Date:   Tue, 21 Apr 2020 00:48:13 -0700
Message-ID: <CAEXe_M6NcL7Hog=S38vymyuc7JeosNu90yG7=64m_X51pgPcFQ@mail.gmail.com>
Subject: CAN I TRUST YOU?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear Friend,

Please i want you to read this letter very carefully and i must
apologize for berging this message into your mail box without any
formal introduction due to the urgency and confidential of this issue
and i know that this message will come to you as a surprise, Please
this is not a joke and i will not like you to joke with it.I am
Mr.Suleman Bello, a staff in African Development Bank (A.D.B)
Ouagadougou, Burkina faso West Africa.I discovered existing dormant
account for years. When I discovered that there had been neither
continuation nor withdrawals from this account for this long period
and according to the laws and constitution guiding this banking
institution, any unserviceable account for more than (7) seven years,
that fund will be transferred to national treasury as unclaimed fund.

I Hoped that you will not expose or betray this trust and confident
that i am about to extablish with you for the mutual benefit of you
and i.I need your urgent assistance in transferring the sum of $10.5
)million usd into your account within 7 banking days. This money has
been dormant for years in our Bank, and The request of foreigner in
this transaction is necessary because our late customer was a
foreigner and a burkinabe cannot stand as next of kin to a
foreigner.Because of the static of this transaction I want you to
stand as the next of kin so that our bank will accord you the
recognition and have the fund transferred to your account.

Upon your response, I shall then provide you with further information
and more deities that will help you understand the transaction. I am
expecting your urgent response to enable me inform you on how the
business will be executed. Please I would like you to keep this
transaction confidential and as a top secret or delete if you are not
interested.

Thanks
Mr.Suleman Bello.
N.B: PLEASE CONTACT ME THROUGH MY PRIVATE EMAIL
( suleman_bello@yahoo.com ) SO WE CAN COMMENCE ALL ARRANGEMENTS AS
SOON AS POSSIBLE.
