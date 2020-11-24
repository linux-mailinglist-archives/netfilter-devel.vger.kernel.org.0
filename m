Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E6D2C2EEC
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Nov 2020 18:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403933AbgKXRjc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 24 Nov 2020 12:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403793AbgKXRjc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:39:32 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183DC0613D6
        for <netfilter-devel@vger.kernel.org>; Tue, 24 Nov 2020 09:39:32 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id DE8B55872C6C0; Tue, 24 Nov 2020 18:39:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DA44160C218A2;
        Tue, 24 Nov 2020 18:39:30 +0100 (CET)
Date:   Tue, 24 Nov 2020 18:39:30 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons 0/4] geoip: script fixes
In-Reply-To: <20201124172902.GB807877@azazel.net>
Message-ID: <754nq976-r324-71sr-s833-osq916s47082@vanv.qr>
References: <20201122140530.250248-1-jeremy@azazel.net> <702191n9-1n33-9027-n968-nqs36r0q288@vanv.qr> <20201124172902.GB807877@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tuesday 2020-11-24 18:29, Jeremy Sowden wrote:
>On 2020-11-22, at 17:55:03 +0100, Jan Engelhardt wrote:
>> On Sunday 2020-11-22 15:05, Jeremy Sowden wrote:
>> > Jeremy Sowden (4):
>> >   geoip: remove superfluous xt_geoip_fetch_maxmind script.
>> >   geoip: fix man-page typo'.
>> >   geoip: add man-pages for MaxMind scripts.
>> >   geoip: use correct download URL for MaxMind DB's.
>>
>> Applied.
>
>Thanks!  I only see 1-3 in your tree, however.

Indeed, now it's there.
