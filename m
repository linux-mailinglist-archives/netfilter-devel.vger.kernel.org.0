Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0116705DCC
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 May 2023 05:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjEQDLY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 16 May 2023 23:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjEQDLL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 16 May 2023 23:11:11 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E035A0;
        Tue, 16 May 2023 20:11:00 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-77d0d8cb127so122215241.2;
        Tue, 16 May 2023 20:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684293060; x=1686885060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpoceKoUcMghMjysxAMh4pXlUVkDe4VViaz0GHunA+E=;
        b=BonBa1yz2RlZBPaehqfAgR8/n9PX25FKps3NaR6e8FN32KaJElz7K2lJkFUOnBn2vO
         EaWTf56NW6opnEimaVV4Ao+tqMpgnsndCVb8QpwRH2VIVzCt+Xd17fWtwrqhFERDS3F4
         KSH2kUh8BJEXr0wTNupnirxPAR+bsgtvs7IrLoMiwsxCbLJrmDzurO8aP4d/t/nD9rKx
         gD94Xc66ql0sAaRLlXA4YY8jCt0SxZItojB2zDxSHu9jGvqLgAVdQdkaokGUh8NYuzLf
         ScPStejc8tKbopsDDlGUj0G6XvUeFxnutG6EDkb1uN2R+5TKR9IT6xE1KLJA7EhC97P5
         MzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684293060; x=1686885060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpoceKoUcMghMjysxAMh4pXlUVkDe4VViaz0GHunA+E=;
        b=MsBS9cXlH/vSXmrNAy/r+6eK4HmEZKCO1lWUEjjK6ae25kKUDII9ePZRlN1DyXJcBT
         cEEbydr0i8YsKhZX8+KtFd6OD1EedREUCq0s6rSc3DF1AAveH0bS+0ceWPbhB9H/HasG
         5tjEAKDxB8ScJrg746VLxrLN4o1SFsg4XjIfQlsramWlkSFQrhwCk6QOZV0sBMXQiRoC
         EOTnRJTvwjO1wpktL8xcT/wVYrhm9nt8UDnqH52XmYhK6gYejenp4r4f+g3hw1Pp+Sd6
         C32ebJZiih/RaNXIoo2uD6YECc7pXPAcb6rXoqV2aQy+LJknDD4jgAujG8HRPxa1Ebjy
         ZAhQ==
X-Gm-Message-State: AC+VfDysPOiTsiiWvB+Al5n5bLEj2UzJgRWpqTI7a3NAns5+AGY/mW7n
        ZpSjHcPeg4m9x4vy/pdsgT9W0CFNf6ha/iahk5g=
X-Google-Smtp-Source: ACHHUZ61UYoXeOYT1ECLpJymT+jTY7OPhbI4KcnvoxCzLVf7ms0Owuaj/sGy+dvPPEmNYiXC1358sFA7kPtdNx9ZSDc=
X-Received: by 2002:a67:ad04:0:b0:434:4809:5520 with SMTP id
 t4-20020a67ad04000000b0043448095520mr16206355vsl.25.1684293059656; Tue, 16
 May 2023 20:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230412-increase_ipvs_conn_tab_bits-v2-1-994c0df018e6@gmail.com>
 <56b88a99-db88-36e4-9ff1-a5d940578108@ssi.bg> <CACXxYfy+yoLLFr0W9HYuM78GjzJsQvbHnm43uRQbor_ncQdMgw@mail.gmail.com>
 <02f51077-3cda-b4aa-a060-3c420cc72942@ssi.bg>
In-Reply-To: <02f51077-3cda-b4aa-a060-3c420cc72942@ssi.bg>
From:   Abhijeet Rastogi <abhijeet.1989@gmail.com>
Date:   Tue, 16 May 2023 20:10:22 -0700
Message-ID: <CACXxYfyXdL9vZ39D+TRqT5=uHB+Gh6_16YKqXfc9QzPCnB_34w@mail.gmail.com>
Subject: Re: [PATCH v2] ipvs: increase ip_vs_conn_tab_bits range for 64BIT
To:     Julian Anastasov <ja@ssi.bg>
Cc:     Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

@Julian, Thank you for the clarification. I've sent v3 and I truly
appreciate your patience with this.

On Mon, May 15, 2023 at 10:35=E2=80=AFPM Julian Anastasov <ja@ssi.bg> wrote=
:
>
>
>         Hello,
>
> On Mon, 15 May 2023, Abhijeet Rastogi wrote:
>
> > Hi Julian Anastasov,
> >
> > >Can you keep the previous line width of the above help
> > because on standard 80-width window the help now gets truncated in
> > make menuconfig.
> >
> > Refer this screenshot: https://i.imgur.com/9LgttpC.png
> >
> > Sorry for the confusion, I was already expecting this comment. The
> > patch had a few words added, hence it feels like many lines have
> > changed. However, no line actually exceeds 80 width.
> >
> > Longest line is still 80-width max. Do you prefer I reduce it to a
> > lower number like 70?
>
>         I'm checking in menuconfig where the help text is displayed.
> The word "lasting" is visible up to "last". So, 3 columns are not
> visible. In editor, this line is 84, may be up to 80 should be good.
> You are using editor that represents Tabs as 4 spaces, that is why
> it looks like it fits in 80. Open Kconfig in less. But in editor/less
> does not matter because menuconfig simply ignores the leading spaces
> in Kconfig and considers the text length which should be no more
> than 70.
>
> Regards
>
> --
> Julian Anastasov <ja@ssi.bg>
>


--=20
Cheers,
Abhijeet (https://abhi.host)
