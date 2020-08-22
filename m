Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DE124E699
	for <lists+netfilter-devel@lfdr.de>; Sat, 22 Aug 2020 11:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgHVJE4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 22 Aug 2020 05:04:56 -0400
Received: from mx1.riseup.net ([198.252.153.129]:51148 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgHVJEz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:04:55 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4BYXX71JrWzFmg3;
        Sat, 22 Aug 2020 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1598087095; bh=EOAKjoqrtRSuWn2++u3V++NFPcryAfpwTeF4ZMDq2ec=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RR916+CYNYDhEcIqLOVp7zajwuHRPeuOlvuo/+cbTmddnTNiF/1eLVacXDsyTmmyP
         FSv4yG3zb39ewwuK5WyEHiyWvIdjD8K6qspIvd47CiT5AjGd/FgryXIbtItL4YaoZx
         jfpM2V0W/xxX5WYpVCuG4hDMy/6pnuKfpW/8osPg=
X-Riseup-User-ID: EA1AAC2A493F12143479ABA37D13B3A3CAF23E464E27EDB4E30C1162278C2475
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 4BYXX61tndz8v0S;
        Sat, 22 Aug 2020 02:04:54 -0700 (PDT)
Subject: Re: [PATCH nf-next 1/3] netfilter: nf_tables: add userdata attributes
 to nft_table
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <20200820081903.36781-1-guigom@riseup.net>
 <20200820081903.36781-2-guigom@riseup.net> <20200821172112.GA15625@salvia>
From:   "Jose M. Guisado" <guigom@riseup.net>
Message-ID: <62ec1a06-e06c-fdfc-e9e2-7ebc71d0f7d9@riseup.net>
Date:   Sat, 22 Aug 2020 11:04:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200821172112.GA15625@salvia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 21/8/20 19:21, Pablo Neira Ayuso wrote:
>         if (nla[NFTA_TABLE_USERDATA]) {
>                 udlen = nla_len(nla[NFTA_TABLE_USERDATA]);
>                 table->udata = kzalloc(udlen, GFP_KERNEL);
>                 if (table->udata == NULL)
>                         goto err_table_udata;
> 
>                 nla_memcpy(table->udata, nla[NFTA_TABLE_USERDATA], udlen);
>                 table->udlen = udlen;
>         }
> 
> Probably this simplification instead? kzalloc() zeroes the table
> object, so table->udata is NULL and ->udlen is zero.

I see. The reason why I didn't simplify at first was because when using 
other nf_tables_new* functions with userdata support as reference (like 
newset or newrule), these are checking for userdata length obtained via 
nla_len before calling nla_memcpy.

