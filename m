Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C827354DF1A
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Jun 2022 12:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376658AbiFPK3I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Jun 2022 06:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiFPK3H (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Jun 2022 06:29:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745715DA65
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jun 2022 03:29:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c4so1498649lfj.12
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Jun 2022 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=b4J3bZRs/alFl9SEuRqXaWDcje6GhrIjPYFFLyOKbAtnasbAByul4uymP+yv1sTGEl
         iT8KKDPQi58E8ln2kcpmbIY+6+16VAJD/Xfy+vGH36iOfaDOI5CSKdvdWcSCviJwbDxh
         gOosbpUiwoMuqm70nKvBmcE8qP7wElJwTBTqfD+BM/CXWxZQngoyI/RLLHcY+hncFwAH
         /e4DuJ/C/MjWKTTfrSnIVya4QjWCJzBy0MNA86Mgvs3rKbznMir1JUEmIGS1k9ZbLq8v
         BejSbraVWZTk7SFp0090KlTNRmzc8jVY5yu7w+62pifDIyLvYQM+BCaOi9Uspy4R6KnE
         ergw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=jPxMnySo/V2l8Cm9HnkdHj2GnkgiLgQ37tiA5TU34gNeps+MBi+SESYppXjT4BO4dZ
         22LivvBew0zFv83TBJW77LzrmxInFayxRtz4bYGq/ue9eYzMyoZeyDQkzGh6ulJm3aLO
         la62VPMpU8DqypsoQrZtX2MIg+9UqeU8e17MBnk0mwYZyeotTJegGakpXjQgxOrLZO9G
         hPxgsmVProOG3ohzpk4J67W5NFBgDeIxi28BjsS0ufqVWnNhMUdbsO5LvKgAmRCq/afO
         E/Kthl1pb5RTaGwi420OeYL5YqD71FTNnepzevaoGvIbY0SWtioqslxDuaVUjPUGhStl
         5jkA==
X-Gm-Message-State: AJIora+OqyHODg0jkFZwiWTmURHt2z3mKf5XF3xn+o4HHiw2+maAgnSn
        21OpxdFDm08EtAsJhY8mV9GBiM+f80vBdo2ckJw=
X-Google-Smtp-Source: AGRyM1sihOJ6y2QIJguLWTCgajj1CnWCUPCK0NdatndYj9qVJ33e8+Su3UXy7HKJyqqaOzxyLB0Ku6u7W1DsQB3s6fQ=
X-Received: by 2002:a05:6512:2e7:b0:478:f55e:f490 with SMTP id
 m7-20020a05651202e700b00478f55ef490mr2224930lfq.486.1655375338656; Thu, 16
 Jun 2022 03:28:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:28c2:b0:1f3:cf5:e20d with HTTP; Thu, 16 Jun 2022
 03:28:57 -0700 (PDT)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <bashirusman02021@gmail.com>
Date:   Thu, 16 Jun 2022 11:28:57 +0100
Message-ID: <CAGOBX5ZEzS0=cvWe8d15dyJB5HrXyiE+CR62wjS8_dXLKBdrgg@mail.gmail.com>
Subject: DARLEHENSANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Mobiltelefon:
*Land:
