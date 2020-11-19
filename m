Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A23D2B9CA9
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Nov 2020 22:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKSVKF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Nov 2020 16:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgKSVKF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Nov 2020 16:10:05 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B7C0613CF
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Nov 2020 13:10:04 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 35B7B589BBA27; Thu, 19 Nov 2020 22:10:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 32B9460F3101A;
        Thu, 19 Nov 2020 22:10:03 +0100 (CET)
Date:   Thu, 19 Nov 2020 22:10:03 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
cc:     netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [ANNOUNCE] ipset 7.8 released
In-Reply-To: <alpine.DEB.2.23.453.2011192141150.19567@blackhole.kfki.hu>
Message-ID: <45rqn0n5-5385-o997-rn9q-os784nqrn9p@vanv.qr>
References: <alpine.DEB.2.23.453.2011192141150.19567@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2020-11-19 21:48, Jozsef Kadlecsik wrote:
>
>I'm happy to announce ipset 7.8 which includes a couple of fixes, 
>compatibility fixes. Small improvements like the new flags of the hash:* 
>types make possible to optimize sets for speed or memory and to restore 
>exactly the same set (from internal structure point of view) as the saved 
>one.

LIBVERSION changed from 14:0:1 (ipset 7.6) to 14:1:2,
producing libipset.so.13 (7.6) and now libipset.so.12

That seems incorrect! It should have been
- 14:0:1 (no changes)
- 15:0:2 (compatible changes)
- 15:0:0 (incompatible changes)
