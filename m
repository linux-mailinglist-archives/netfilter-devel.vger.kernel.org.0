Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D12E756043
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jul 2023 12:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGQKUl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jul 2023 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjGQKUk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:20:40 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3815E1BE;
        Mon, 17 Jul 2023 03:20:38 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8C8225872FFD4; Mon, 17 Jul 2023 12:20:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8A91460D6E2C6;
        Mon, 17 Jul 2023 12:20:36 +0200 (CEST)
Date:   Mon, 17 Jul 2023 12:20:36 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
cc:     netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org,
        netfilter-announce@lists.netfilter.org, lwn@lwn.net,
        guigom@riseup.net
Subject: Re: [ANNOUNCE] libnftnl 1.2.6 release
In-Reply-To: <ZLUHo/spWd98PMUS@calendula>
Message-ID: <p722n04o-80pp-6573-r832-621610s2r749@vanv.qr>
References: <ZK2KUlzZzlQ8/mKa@calendula> <36852014-p9pp-srp2-pn24-orr4385p70qo@vanv.qr> <ZLUHo/spWd98PMUS@calendula>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Monday 2023-07-17 11:19, Pablo Neira Ayuso wrote:
>On Mon, Jul 17, 2023 at 10:09:09AM +0200, Jan Engelhardt wrote:
>> 
>> On Tuesday 2023-07-11 18:58, Pablo Neira Ayuso wrote:
>> >The Netfilter project proudly presents:
>> >        libnftnl 1.2.6
>> 
>> Something is off here.
>> With 1.2.5 I had:
>> 
>> /usr/lib/python3.11/site-packages/nftables
>> /usr/lib/python3.11/site-packages/nftables/__init__.py
>> 
>> With 1.2.6 I get:
>> 
>> /usr/lib/python3.11/site-packages/nftables-0.1-py3.11.egg/nftables/__init__.py
>
>Could you revert:
>1acc2fd48c75 ("py: replace distutils with setuptools")
>I suspect the problem is in the update from distutil to setuptools.

Revert alone is not enough; a removal of python3-setuptools from the
buildroot is also needed to restore the previous structure, which
suggests there is an autoforwarding mechanism in python :(
