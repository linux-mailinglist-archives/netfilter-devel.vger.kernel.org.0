Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372A02B9216
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Nov 2020 13:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgKSMGI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 19 Nov 2020 07:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgKSMGI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:06:08 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30443C0613CF
        for <netfilter-devel@vger.kernel.org>; Thu, 19 Nov 2020 04:06:08 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 5F29A588CBBD6; Thu, 19 Nov 2020 13:06:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 5AF0860D8A2E2;
        Thu, 19 Nov 2020 13:06:05 +0100 (CET)
Date:   Thu, 19 Nov 2020 13:06:05 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Philip Prindeville <philipp_subx@redfish-solutions.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: Issues w/ db-ip country database
In-Reply-To: <E9387BD8-079E-4E05-B964-4FA7986B47E8@redfish-solutions.com>
Message-ID: <438q8o9q-p8qq-3969-2561-96915r3q39rp@vanv.qr>
References: <8B419AF6-031F-4F6A-A3FB-3118780F6119@redfish-solutions.com> <2qp4q17-pqpo-2q0-24r0-q466sro3pp44@vanv.qr> <B6D36DF0-178A-4985-AB85-4BEE2AAD9116@redfish-solutions.com> <548ron6o-rq26-725-rqp4-r0p6n83r36r@vanv.qr> <EC421C64-614D-40CC-B544-40DB2A657EE4@redfish-solutions.com>
 <E9387BD8-079E-4E05-B964-4FA7986B47E8@redfish-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wednesday 2020-11-18 05:02, Philip Prindeville wrote:
>>> 
>>>> 212.174.0.0/15 supposedly is a single block of TurkTelecom, but the database
>>>> shows it as being 296 subnets, mostly /23’s.
>>> 
>>> and to add icing, WHOIS has four entries for it.
>>> 212.174.0.0/17 212.174.128.0/17 212.175.0.0/17 212.175.128.0/17
>> 
>> Yeah, I don’t get that either.
>
>https://sourceforge.net/u/pprindeville/xtables-addons/ci/revert-to-maxmind/tree/
>So you can use that until the dust settles and we figure out the discrepancies.

I added them to the main xt-a repo (but xt_geoip_dl_maxmind probably won't do
much these days).
