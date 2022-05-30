Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021F7538494
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 May 2022 17:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiE3PQ6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 May 2022 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiE3PQg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 May 2022 11:16:36 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B59B47AF1
        for <netfilter-devel@vger.kernel.org>; Mon, 30 May 2022 07:16:52 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j16so2374298ilk.8
        for <netfilter-devel@vger.kernel.org>; Mon, 30 May 2022 07:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=Lpl6uIHb/CUKBxaRsaZ6qp/Z90iHvECzKfKO6KapKsd+X++aqtVGKj4nud9t9YOOjR
         mSUD934dwewAuu7nwpFLF2urLZmfkAx/XCloMnYVh/79qXX9bflRK4hiR/JhWJciNKl0
         kHmvmw41AiMzQx0yyvpXZ+QFybWrdqFaOmYIaEKgiwDFX9ZAzkzKyw4dbdCpD14gxLHw
         ngns3k/JMJSrpufV+3dobpw92aWWiulY/nUxo0/Mekd3EZ2Y7kxFFy3NX6bGIlBNURgq
         4Ye6yXP5vsTCqNqup9C6FeiRejGBfvkdObdRNxELoD9Cby8VqNphL2oCtq/Zdt6APd4O
         2aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=Tlbt0k+jXcpjAqJKM8Aq4eXjxZqURAWqda7YNvJNm0QdZgCNE7lwOaMbYXG76sa8Xv
         g4/GWcz5qMm+qh+jjAMwNZ2zPadVOtgVl4EIVONFriFocoOrtxeUeJ7IfrtXXN/TvlrE
         3GNZ0HdbYSkWY8YNvOD7iDR+g77NfWcpFmQxpU4axACpxO3Q6AkGKLorm7h3gzsmNKBy
         Jx1ThBUBc1r/r2ND8GwuoO97Q43EJE06PYJ6CNnm98T1zOIH7CxubjxSLguS50FeW3/K
         laxDv4NLo4wj5JBb0PXdexkAMzfzqGGHvELyC9FkmG36ecq01sFd/gpnlaoCBdPtcPVE
         FEkA==
X-Gm-Message-State: AOAM532iL16igIKGU0Z0nwsZ/YIMTUOUKaEoYltbSUwNBkggNv+JZA+u
        RGPjiQZMVHC7PsOqfEXpoDYw13wRj/iEbLbta6g=
X-Google-Smtp-Source: ABdhPJzoaioOXcTz1TIMGdBOX4OiQu8GzAayVCziCp/mdWdOA5BywNDbmP7YOcFaMhDclDneo+y4SuNS4IDNXHzQNTo=
X-Received: by 2002:a05:6e02:1245:b0:2d3:a86e:c587 with SMTP id
 j5-20020a056e02124500b002d3a86ec587mr2629094ilq.274.1653920211583; Mon, 30
 May 2022 07:16:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:f06:0:0:0:0 with HTTP; Mon, 30 May 2022 07:16:50
 -0700 (PDT)
Reply-To: barristerbenjamin221@gmail.com
From:   Attorney Amadou <koadaidrissa1@gmail.com>
Date:   Mon, 30 May 2022 07:16:50 -0700
Message-ID: <CAOh7+P-Zuro85N8Y9XOMAr-7nG=3VLLfxScij0FSYKGayQL_dw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:144 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [koadaidrissa1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [barristerbenjamin221[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [koadaidrissa1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

SGVsbG8gZGVhciBmcmllbmQuDQoNClBsZWFzZSBJIHdpbGwgbG92ZSB0byBkaXNjdXNzIHNvbWV0
aGluZyB2ZXJ5IGltcG9ydGFudCB3aXRoIHlvdSwgSQ0Kd2lsbCBhcHByZWNpYXRlIGl0IGlmIHlv
dSBncmFudCBtZSBhdWRpZW5jZS4NCg0KU2luY2VyZWx5Lg0KQmFycmlzdGVyIEFtYWRvdSBCZW5q
YW1pbiBFc3EuDQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCuimquaEm+OB
quOCi+WPi+S6uuOAgeOBk+OCk+OBq+OBoeOBr+OAgg0KDQrnp4Hjga/jgYLjgarjgZ/jgajpnZ7l
uLjjgavph43opoHjgarjgZPjgajjgavjgaTjgYTjgaboqbHjgZflkIjjgYbjga7jgYzlpKflpb3j
gY3jgafjgZnjgIHjgYLjgarjgZ/jgYznp4HjgavogbTooYbjgpLkuI7jgYjjgabjgY/jgozjgozj
gbDnp4Hjga/jgZ3jgozjgpLmhJ/orJ3jgZfjgb7jgZnjgIINCg0K5b+D44GL44KJ44CCDQrjg5Dj
g6rjgrnjgr/jg7zjgqLjg57jg4njgqXjg5njg7Pjgrjjg6Pjg5/jg7NFc3HjgIINCg==
