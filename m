Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917191F76B1
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2020 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgFLKY1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 12 Jun 2020 06:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgFLKY1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:24:27 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B194C03E96F;
        Fri, 12 Jun 2020 03:24:26 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jjgr7-0004HM-O6; Fri, 12 Jun 2020 12:24:13 +0200
Date:   Fri, 12 Jun 2020 12:24:13 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel@vger.kernel.org
Cc:     netfilter-announce@lists.netfilter.org, netfilter@vger.kernel.org
Subject: [ANNOUNCE] libnetfilter_queue 1.0.5 release
Message-ID: <20200612102413.GD21317@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi!

The Netfilter project presents:

        libnetfilter_queue 1.0.5

The only change compared to version 1.0.4 is releated to documentation.
To build/install doxygen documentation, you will now need to pass the
"--with-doxygen" option to the "configure" script.

There are no changes to the library itself.

You can download it from:

https://www.netfilter.org/projects/libnetfilter_queue/downloads.html

Have fun!
