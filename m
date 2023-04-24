Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64716ECB13
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Apr 2023 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjDXLMz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Apr 2023 07:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDXLMy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:12:54 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1949630D5
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Apr 2023 04:12:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5529f3b8623so27344527b3.2
        for <netfilter-devel@vger.kernel.org>; Mon, 24 Apr 2023 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682334772; x=1684926772;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G7upYASidmeqEEydII3qqc7RD6bnaXjO6ELYE2uwAgE=;
        b=fW1L+4egyz7CozVuDiaZvaOJRzLxsIxAjTMEWAesOJT5AqbqFEC7vsVl/ZcKJztezU
         kxkRMGu/I5TRLDkXUgd01QzZUp9meewt2D1rdJaKZvo6ErGYy80BgtvrBhWURcAFwhFo
         vNGnX8qVwua0fLHkKXQhVSjIZcA+J32w8UvW81BGC7XjNUfTpuxgEVybgTWm2dg3hpmm
         EaaOx2x8o3d2sN6sunVawnnzxNmGIwYkXXBJk0rgvyB7fhCaea3pRUXDpbCvSs5SI/fU
         U8qREosuhB8xbsI3oTL/bCyUlNxIWBST3JYTA2DZoYW0hu7+VMButn0n64pz+uFw8pYV
         WQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682334772; x=1684926772;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7upYASidmeqEEydII3qqc7RD6bnaXjO6ELYE2uwAgE=;
        b=cFUczBXsVq/o1OXf+Xzm0GNrgCrvnu3l8SSPnX2lMg2MNNEJOaCU/UiJK//x78MIap
         lZ8HbzTY4DZIsM0T4wTxLtCJvZfik69IXSWG2MR+321C/c6Eaf9Lu6xynJpe4ty0NOMR
         XwGaGSydRAVQD1xbFNzEdzaNpPHT0ZeLb+bP81r75cg3V1LuL0yvQpLt3Svj9vAzr5lE
         40I92pcHhc8rKwwXqD+hlxfxAmy/mHp5yYJcutC1dVHKS/RCQF1ZC/GyN9mboIVlw8As
         9JrK9G71PAjxIoOuLYx7h/Rwo/oXIEJA08OLu7T/uRcmz3eIuIospc2N98aJ2qMA/SN2
         K0hg==
X-Gm-Message-State: AAQBX9fF1+t3k7qed8cVr120dhhE0HzEraa0eaobIkYzPMKNrathvaU1
        iZoeccoGESNA/F/YwpmXwZYon30aA4Q1S76UY0E=
X-Google-Smtp-Source: AKy350YQ6saj2pPBhL4BNueqSmUmkJdxjt4KCjqUI2JbhsgR93eT02Oup2bnqhCD9n438jLjrX2/OnNQG2BPaoiGGds=
X-Received: by 2002:a81:a547:0:b0:54f:752e:9e60 with SMTP id
 v7-20020a81a547000000b0054f752e9e60mr7187612ywg.37.1682334772239; Mon, 24 Apr
 2023 04:12:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7189:b0:2f2:1ebc:1f88 with HTTP; Mon, 24 Apr 2023
 04:12:50 -0700 (PDT)
From:   Mariam kouame <mariamkouame.info01@gmail.com>
Date:   Mon, 24 Apr 2023 04:12:50 -0700
Message-ID: <CAO9Ukgbz1XB5hh-P2VB6_YxgsejkTNkrEHJNmwm3PCBub4f0Qg@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
