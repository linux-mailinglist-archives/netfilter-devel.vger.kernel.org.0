Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67750627A4D
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Nov 2022 11:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiKNKSa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Nov 2022 05:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiKNKS1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:18:27 -0500
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066011A6
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Nov 2022 02:18:23 -0800 (PST)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4N9ldC1zVLz9t48;
        Mon, 14 Nov 2022 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1668421103; bh=wZQlkGrRlDghzG4rEAXaqe7gS19MK3a4xGOz5KrYupQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EE0ZiBgAdju8OLk7JFcnRkKYuBamKkma356nOHbYDPgamebSwzkfD1grqHbDgBd9c
         x/wkfD80/WxljbRaBo4+zQMlXYHHHH4rPWxW+Oke7cLYtAxbZmzB02CXFXbAkb6gpQ
         1iO0PB8/MmYec28asjVyHhu+aGJ7iTUeyCF5KiIQ=
X-Riseup-User-ID: 652C596D49B0CE9029AA86A874B0AD857BB7F4BFEE3B77FE7E85AA88D25E51C6
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4N9ldB4B5Fz5vMZ;
        Mon, 14 Nov 2022 10:18:22 +0000 (UTC)
Message-ID: <7b3d9296-fa8c-84a9-6c8f-077a84d7e0a7@riseup.net>
Date:   Mon, 14 Nov 2022 11:18:19 +0100
MIME-Version: 1.0
Subject: Re: [PATCH nf-next v3] netfilter: nf_tables: add support to destroy
 operation
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
References: <20221029085940.10307-1-ffmancera@riseup.net>
 <Y2ulROgS20ef92+i@salvia>
Content-Language: en-US
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
In-Reply-To: <Y2ulROgS20ef92+i@salvia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On 09/11/2022 14:04, Pablo Neira Ayuso wrote:
> On Sat, Oct 29, 2022 at 10:59:40AM +0200, Fernando Fernandez Mancera wrote:
>> Introduce NFT_MSG_DESTROY* message type. The destroy operation performs a
>> delete operation but ignoring the ENOENT errors.
> 
> A made a few comestic updates, then I realize we also need to handle
> this from the command and abort paths. We also might need to update
> the _notify() functions to report the destroy events to userspace
> (that is still missing in the patch that I'm attaching).
> 
> I think this is almost there but it needs a bit more work.
> 
> Note, this patch applies on top of latests Phil's update on nf-next.

Thanks Pablo, let me handle the _notify() functions and will send a new 
version of the patch.

Thanks,
Fernando.
