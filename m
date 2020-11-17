Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FDB2B5AB2
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Nov 2020 09:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKQIGt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Nov 2020 03:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgKQIGt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:06:49 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD0C0613CF
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Nov 2020 00:06:49 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 7349058727084; Tue, 17 Nov 2020 09:06:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6FD4060C22EC1;
        Tue, 17 Nov 2020 09:06:46 +0100 (CET)
Date:   Tue, 17 Nov 2020 09:06:46 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Philip Prindeville <philipp_subx@redfish-solutions.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: Issues w/ db-ip country database
In-Reply-To: <8B419AF6-031F-4F6A-A3FB-3118780F6119@redfish-solutions.com>
Message-ID: <2qp4q17-pqpo-2q0-24r0-q466sro3pp44@vanv.qr>
References: <8B419AF6-031F-4F6A-A3FB-3118780F6119@redfish-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Tuesday 2020-11-17 04:36, Philip Prindeville wrote:
>
>Many known blocks owned by Chinanet for instance, don’t show up as /11 or /13
>networks, but as dozens of /23 networks instead in China, the US, Japan, and
>Canada. Clearly not correct.

Do you have some sample netnumbers so that we can look at it from our side?
