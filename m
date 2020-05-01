Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0041C1F42
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2020 23:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgEAVJL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 1 May 2020 17:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAVJK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 1 May 2020 17:09:10 -0400
X-Greylist: delayed 19775 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 May 2020 14:09:10 PDT
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0555C061A0E
        for <netfilter-devel@vger.kernel.org>; Fri,  1 May 2020 14:09:10 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 4D6B6580C903F; Fri,  1 May 2020 23:09:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 4C5BB60D444A9;
        Fri,  1 May 2020 23:09:07 +0200 (CEST)
Date:   Fri, 1 May 2020 23:09:07 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Philip Prindeville <philipp@redfish-solutions.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] xtables-addons: geoip: install and document
 xt_geoip_fetch
In-Reply-To: <20200430221546.12964-1-philipp@redfish-solutions.com>
Message-ID: <nycvar.YFH.7.76.2005012309030.22615@n3.vanv.qr>
References: <20200430221546.12964-1-philipp@redfish-solutions.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Friday 2020-05-01 00:15, Philip Prindeville wrote:

>From: Philip Prindeville <philipp@redfish-solutions.com>
>
>Add a man page for xt_geoip_fetch.1 and include it as part of
>the installed scripts.

Done.
