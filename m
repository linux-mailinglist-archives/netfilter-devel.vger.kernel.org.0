Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB353AD51
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jun 2022 21:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiFATab (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jun 2022 15:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiFATaa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jun 2022 15:30:30 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA517CE5B
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jun 2022 12:28:36 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-f2cbceefb8so3994521fac.11
        for <netfilter-devel@vger.kernel.org>; Wed, 01 Jun 2022 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=HLFKV03IvnCnmYNulbqEkPjTK3riUL87h2wHAPtiQ15M9iY6Q8e992KMQxJwLdk6f+
         yc6asPWVRklcz8AY8oqwyi19SO9Z3FXfSKl8KIcHwdn2diZ16fcVN3Noj9XYHhxCnXOp
         L86c6aBumcYcai1ti0jT0anzEO5LqUJSpP7KiFxQXIe3O9qnWY7viJfSABa1ly9ubc5O
         7xqU4M/fQQEbpLLu8u6cCuAo0xRfp/5LoTJYIMP5ne/O4VXGwgI3hKlV02ue3fdzqvYA
         6IABKhDngCz8ZKTuipfv5GZ/7HEqJFbM8x/u/85qQFiKTPs+Mb3XRU84XoMrlsTu1Zr+
         PsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Gk4nfCem3ECRa7Gml0J0mN/3RZoOAdfGaQAqyHPKtiI=;
        b=GS2CqEXCYhwHIdQEBLw+h8xcOEc8d2k0ihUlLJtPufZew1Zyt7T5VDC3XOP/7pjVg6
         JVRqyWPlR8D6EQ9Z5QEpsmr7Jzk/GqU1vx0EyHLXS4FQ2ZQdZfROKZkCUB0CmhTP97q8
         Ke0lg5DCv8KnC9NZ0eTgiWLnL3RsoRG5VV3FEj08/lGqQ7xLPiPD2qZkrOROm/fiBXnO
         4qbuppOdBnioNVNHsNNbgMeD9ijqoQVmsHyB4iCMoaEvoG/qdNpsG4755FMlCa8HBi9C
         lUyCCGxMqxVDGlwA02cIbRbKOBoR3QdIl3DKuHckmR10UrhWVYJr8p/l4+e7mbDHVhmC
         UetQ==
X-Gm-Message-State: AOAM532PKXRscFG+92zpeTGrv4pX76LmQoTdBn2a32q2pfruJp7Tvo0v
        W/A7roung5gxLwymPL2yOfI25qFZxj0gGMGPxMfVma424Pc=
X-Google-Smtp-Source: ABdhPJzieEZsH3sz7p7h/CGCrygaKC3twss2VqEDgMRTw52PjXyF0yZxDsfC/Wcw+CTWK4gcBihtpQQBph7O0cnThRw=
X-Received: by 2002:a05:6870:308:b0:f1:ddfe:8ac5 with SMTP id
 m8-20020a056870030800b000f1ddfe8ac5mr16670934oaf.237.1654111051378; Wed, 01
 Jun 2022 12:17:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:3601:b0:a3:2139:251d with HTTP; Wed, 1 Jun 2022
 12:17:30 -0700 (PDT)
Reply-To: johnwinery@online.ee
From:   johnwinery <alicejohnson8974@gmail.com>
Date:   Wed, 1 Jun 2022 12:17:30 -0700
Message-ID: <CAFqHCSSUC0MpbjYK8d-GCxOG4b6Qbk2uH3+xQDZte6cPBsxLGA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Greeting ,I had written an earlier mail to you but without response
