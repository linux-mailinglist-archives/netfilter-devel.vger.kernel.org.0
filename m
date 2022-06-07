Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A2E53A930
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jun 2022 16:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiFAO21 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jun 2022 10:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354854AbiFAO1y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:27:54 -0400
Received: from mail1.systemli.org (mail1.systemli.org [93.190.126.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2C15A2B
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jun 2022 07:23:06 -0700 (PDT)
Message-ID: <1678505c-aa11-6fcf-87b4-eeaa0113af62@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1654093384;
        bh=j84lh/yh5eQMUmj5nJCakTeEmvQOsjF6S+ugger8aXM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=sW7wHIwH7EFlLzSJz16C+VkVe6ZLLK8rdOcivsRG/CkTFamWPrjxh4lyGhCuoIIsh
         VNlNodRl91s2zbruP5s34QoM+H4GvetsDt3URIts5BoH5W4sflcfKIYFi421VtQRY4
         43HgIMt3Ybz3Xkhu3HGHi90Th7nUtgenwWj5Aqzyd1JkgTZINOuLkbN9MqJtvy6tYn
         zHvasgUAuD+pVu2Up10LRRGJUH78UazhZX7kVGjOgwrIUWf6FsbHMe+rXk0xyfjNl1
         6eAwRAYMC3qGFYouFET938J9pQSj2z/GnbXAZGWuTZ6o6ibi91DuebIhq1k6wKzLFs
         ivFzKEESqwk+A==
Date:   Wed, 1 Jun 2022 16:22:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "Simplify static build extension loading"
Content-Language: en-US
To:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org
References: <20220601134743.14415-1-vincent@systemli.org>
 <YpdvYPV5L7Mxs3VQ@orbyte.nwl.cc>
From:   Nick <vincent@systemli.org>
In-Reply-To: <YpdvYPV5L7Mxs3VQ@orbyte.nwl.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

More Information:
https://github.com/openwrt/openwrt/pull/9886#issuecomment-1143191713

I have to debug further.

On 6/1/22 15:53, Phil Sutter wrote:
> On Wed, Jun 01, 2022 at 03:47:43PM +0200, Nick Hainke wrote:
>> This reverts commit 6c689b639cf8e2aeced8685eca2915892d76ad86.
>>
>> The stubs broke the libiptext used in firewall3 by OpenWrt.
> What's the problem?
