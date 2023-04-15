Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD336E3318
	for <lists+netfilter-devel@lfdr.de>; Sat, 15 Apr 2023 20:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDOSVe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 15 Apr 2023 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDOSVd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 15 Apr 2023 14:21:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08665270A
        for <netfilter-devel@vger.kernel.org>; Sat, 15 Apr 2023 11:21:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id lh8so8544941plb.1
        for <netfilter-devel@vger.kernel.org>; Sat, 15 Apr 2023 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681582892; x=1684174892;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6JQjgUDE1SxlvUoKtzIbQ0h23DC8XvuP/VCa8o54TI=;
        b=STP0KfAZfSL6MYOd01WbAFENCBUd7L7P0XTmyNx/NM/a4YjQZF+ciYNt7fKzmXnHng
         9vg39BT3p+FJ2kF3doZzqKtC3MHfHDJQ9o8S0F9i2xib53e7F1p3K0lKtdFQGi2O/Nwi
         rrr194iTQWNj8cpt49k1THkB9hEFd82I+S3Of79DQGRPt+rNP+jpFQBZZq3RDGvTspaR
         Iuh30y5vk9zJYGoSrHUBcoLqrm0s25Gf/MS1MslwwPRaeuVgGyIcGXy53vHRKbfzCKiz
         LIGMLwVcfBF47PqQyzELIc37nKBQVSIAsmhbRcVxHtD9Wk3+kwvyMvQxeDDtQfu/kcgn
         mbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681582892; x=1684174892;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6JQjgUDE1SxlvUoKtzIbQ0h23DC8XvuP/VCa8o54TI=;
        b=gJ6tM/GplBGszDe9aYswihFWDEykmkrT6zKoDbODKwje9QN/8+qKSkhW5IevO8osDj
         YW8Bq4Nc3+6ScSGkF8vwxdJ0A/+rDWd1hirPgnVmK2EdVyKrj/uHCzs0Lf8kGodsXfuH
         3oYwZmt1/m9WMqlspCAgAcPNGo9N0x9Gv6KsvT0ZXBMqW6bv+KxK9TeAPuFlQ+8Q3LMj
         LLUb3pysKNW6g1s5IFe81QiPBzOxkykhWzhnU2boe9Iy1qbcZ19Pa4xyW9yyY6Qaw3A8
         mJfiRUReBGLoxYYATucwgyuZyeB17blcbtTtn56OsO6ANWWcAJ0SeoGznPOrYlfKtzwg
         azeA==
X-Gm-Message-State: AAQBX9ekn9MjOUOha9hAzhVvk8mVMYVYeHgXYVWCbIlPJozGUkppZ+05
        nWcetnKyfNViPkO+Oc+slxeYinH8JoXgW4ruo3s=
X-Google-Smtp-Source: AKy350ZXJ/nnHVEJHG2sSaybJaMu2mRi4M11kMvcQfFQjonuDDNcY/UPC8TMCQt+eLXSTDbxElikB9thFVQiGpIT7xU=
X-Received: by 2002:a17:90a:de92:b0:23f:a4da:1208 with SMTP id
 n18-20020a17090ade9200b0023fa4da1208mr9931458pjv.39.1681582892124; Sat, 15
 Apr 2023 11:21:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:8ba7:b0:b9:287c:5bc0 with HTTP; Sat, 15 Apr 2023
 11:21:31 -0700 (PDT)
Reply-To: robertcurran39@gmail.com
From:   ROBERT CURRAN <adamuyau630@gmail.com>
Date:   Sat, 15 Apr 2023 19:21:31 +0100
Message-ID: <CAOsSf6UBYVH11bgrLin=kU5HQ=tEQ97xaLCRON25QUxzpoRGTQ@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ATTENTION:

The International Monetary Fund (IMF) in conjunction with the WORLD
BANK have approved your pending inheritor funds and hereby brings this
information to your notice.

You are required to contact this office as you receive this
notification as your recipient's email is listed in our central
database. so that we can normalize documents on your behalf and advise
you on how to make a claim.

Truly,
Robert Curran
Coordinator, International Settlements Unit
