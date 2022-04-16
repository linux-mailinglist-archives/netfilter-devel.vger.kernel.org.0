Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E78E503517
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 Apr 2022 10:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiDPIPr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 16 Apr 2022 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDPIPq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:15:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C549F0F
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Apr 2022 01:13:15 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so10010129pja.0
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Apr 2022 01:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=gCTOHe0CYc8qSmNwyNiVlTuwBLX5pCrf2raldTHagK50t2A6fNjs8o4ZyRDUDHEuos
         G6wKKEir4wHfqvG4lWlEq2j57LfACpYEn/hn2dp/kVDWBcoPZ9E1EAYiSPyEaWeH2hg4
         2ba9pSFDA1SBjHhazDASylBQeKjPMQRkX5qU1wpEYTPDaBXsrEAqytb4Tq0ZuqsLPwvi
         DXoOqax+EXdx5Sr8yw36qq2MTDSL+0eRYu3oVUNypH8VY7tpC/EAIr63b1KBEWM1M/mc
         KjyrgkvKKwQ0ZJFyUP8Ydo3THghXvhZJZKX+p+e3c5AqNfvgzwOxAv55TV3p0df/d2l3
         pImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=kYFksI57i5Q9DTdmwOEH43OY6dIXiSK421l+J7GzQw+qnt4z+SK8j1FU4pv5mn1mJx
         x2DUAAcABPW+SUSpFep6dQdLMfhxKh5dHXfh8bkdzNj8+SbwqfvWUoQvgzWygGmkwrFb
         S0enMqQ22UBNLQkWwDJ7kIMPZsU7Tt9P4va6vyJ22+ghMz5p8PKmVTcFnqfcB9oNdjtz
         4N4mko0OqQYVLiYrK6NUWaNZ4FSHlkmCOnnHIiocyJjSqC23XQq0/9jMsQgbQeCfTyUb
         2SK5919zMjNQ0PP/hOcTsiasOrWTASNTLyf/zrSH+53OJNhWqdImbgsqFsJN0Z2Jy+gl
         oJ9w==
X-Gm-Message-State: AOAM533/Z1mzAsh4Uw4ZM/d3m60mG2VgTUYNNRP16Lb6oZIKFYv7W/W6
        pLZ7Mhu6Df5eoJ4Zy6UNHHottJgGEa42ejipwpw=
X-Google-Smtp-Source: ABdhPJzt3Pa6ZlGiOCOFzRcQfbTefGS0l7dFpER+uumD7nebpfqoIL6+QG7qd0lmvfHf9EkMFkHlgDicDP1+TCDFPfY=
X-Received: by 2002:a17:903:1d0:b0:158:d4c7:99c2 with SMTP id
 e16-20020a17090301d000b00158d4c799c2mr2603030plh.63.1650096794625; Sat, 16
 Apr 2022 01:13:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:640e:b0:5c:e92b:3eb5 with HTTP; Sat, 16 Apr 2022
 01:13:13 -0700 (PDT)
Reply-To: danielseyba@yahoo.com
From:   Seyba Daniel <ceez281990@gmail.com>
Date:   Sat, 16 Apr 2022 10:13:13 +0200
Message-ID: <CAN8=WHxuxzBQQTpV6dvk3A2AABsy7SKgz-R3PFpTsac=vniW5w@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1043 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ceez281990[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ceez281990[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
