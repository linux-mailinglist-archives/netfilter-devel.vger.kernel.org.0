Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963E61F0551
	for <lists+netfilter-devel@lfdr.de>; Sat,  6 Jun 2020 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgFFGIk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 6 Jun 2020 02:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgFFGIj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 6 Jun 2020 02:08:39 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739ECC08C5C2
        for <netfilter-devel@vger.kernel.org>; Fri,  5 Jun 2020 23:08:39 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id D5FE05872323F; Sat,  6 Jun 2020 08:08:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id D1DF060C1F9F6;
        Sat,  6 Jun 2020 08:08:35 +0200 (CEST)
Date:   Sat, 6 Jun 2020 08:08:35 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
cc:     fw@strlen.de, pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 0/1] URGENT: libnetfilter_queue-1.0.4
 fails to build
In-Reply-To: <20200606052510.27423-1-duncan_roe@optusnet.com.au>
Message-ID: <nycvar.YFH.7.77.849.2006060806160.7334@n3.vanv.qr>
References: <20200606052510.27423-1-duncan_roe@optusnet.com.au>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Saturday 2020-06-06 07:25, Duncan Roe wrote:

>'make' says: No rule to build ../fixmanpages.sh: stop
>Maybe you can push out a re-release before anyone else notices?

No to rereleases. That just upsets distros and automated scripts that 
have already downloaded the file (we're now past 23 hours anyway) and 
would raise a "their server was hacked" flag because the 
signatures/checksums no longer match between what's brewing in the 
distro staging and upstream URL.
