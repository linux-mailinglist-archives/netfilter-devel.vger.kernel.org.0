Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1C076B718
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Aug 2023 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjHAOTZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Aug 2023 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbjHAOTU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:19:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A610FD
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Aug 2023 07:19:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so66559451fa.3
        for <netfilter-devel@vger.kernel.org>; Tue, 01 Aug 2023 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690899558; x=1691504358;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxFrUSR++cKFJPITlc+cnIbxe84AGw4zt+YU+6LONT4=;
        b=WftlPFQ1Fg1p1JReeK3gL7o6nustI/EB9K7stZ0gJo6vmvwu2xBLP6NOt61wnV4nVd
         A39hrr1AHXrboz60R6FiWFjXGigJRtO6TAbo6C2R4R8PS0UGs1DfbLJwh6XgjXMdureY
         qbH3ZM/MT924IjtQAd0lbp4cbrL/KfAbd4cXydBuj0QqNCEbTN1oIPIoB7jRSHMjd2gl
         cyRspKnO7RqNvSRRonZhdrCYQ7EJriB7Qu5gNU7r6k8nbDb3uCO5KA/lUE5NY8Y+uR2L
         6wybTzZQ/7t4bjTc2VxNqIW/gxUP4rcsACp0yjvi6ud/4v+GMC9pWCrzXJk/t+L+xCje
         bAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690899558; x=1691504358;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxFrUSR++cKFJPITlc+cnIbxe84AGw4zt+YU+6LONT4=;
        b=VonTR8ARroWtbtH3K948rKEsNn2m4n+i2Riuti/gwEdmoF8wqvjWVxx0Azh65k2jFa
         HZapYZ/Hz7/iozHpjNQPEWhk7/XRlY+gI0nldnNhS9vmLnNuti52IgndjrNuAjlhVtOm
         +DkaCjPS6yQkUYrmOQ8ON8nhMApQp5T/U0VnAVfPBAwmgg+xBcdyyzI58hwEDJiiqgRm
         HqyQfRPH89oNiKQHVHa4x7uvRErQoxsxC9kZwxqL5znrqvN5dBIwsBTKx8KMWgfcDDLy
         uPzsXxYEyzKcu+27OlWYgZhiOJ+zU4QJRW/h4x4XbIWGN7fQznKb3XTbsYJOkhRLVi1w
         vL8w==
X-Gm-Message-State: ABy/qLbVV/2M3MikPZTymwhcLawBLtH0N3bWx84zbDtrl9Srw6SHNqBb
        96pRyE397W/of0OlNBmACs6/qEZA/nyhGZ1c8b4=
X-Google-Smtp-Source: APBJJlGTT5Cslr5hPcqDYbxv8x+DswRz6IBrSkObI1NvkHt0afftn8Y2nTT0eqMbHzGkOTJQwG07drKKUtiVk23a2Nk=
X-Received: by 2002:a2e:3307:0:b0:2b6:e76b:1e50 with SMTP id
 d7-20020a2e3307000000b002b6e76b1e50mr2766001ljc.41.1690899557648; Tue, 01 Aug
 2023 07:19:17 -0700 (PDT)
MIME-Version: 1.0
Sender: ytu062536@gmail.com
Received: by 2002:a05:6504:3c8:b0:239:63a:831 with HTTP; Tue, 1 Aug 2023
 07:19:17 -0700 (PDT)
From:   Mrs Aisha Al-Qaddafi <aaishaalqaddafi7@gmail.com>
Date:   Tue, 1 Aug 2023 16:19:17 +0200
X-Google-Sender-Auth: Du4nXYYv1q6vM9gwPtuEuTejBcY
Message-ID: <CAGCLH7W9Y5uEy26DS+AUW4y6kx_YD=kYCVsPM-m_nM8uBO5=9g@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_80,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:241 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8709]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aaishaalqaddafi7[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ytu062536[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear Friend,

Aisha  Gaddafi is my name, I am presently living in Oman,i am a Widow
and single Mother with three Children, the only biological Daughter of
late Libyan President (Late Colonel Muammar Gaddafi) and presently I
am under political asylum protection by the Omani Government.

I have funds worth $27.500.000.00 US Dollars which I want to entrust
to you for investment project assistance in your country..

Kindly reply urgently for more details.

Thanks
Yours Truly Aisha
