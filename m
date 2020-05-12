Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5301CF19F
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2020 11:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELJaU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 May 2020 05:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgELJaU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 May 2020 05:30:20 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AD3C061A0C
        for <netfilter-devel@vger.kernel.org>; Tue, 12 May 2020 02:30:20 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id D01A358725880; Tue, 12 May 2020 11:30:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id CF24F60D311F3;
        Tue, 12 May 2020 11:30:16 +0200 (CEST)
Date:   Tue, 12 May 2020 11:30:16 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Philip Prindeville <philipp@redfish-solutions.com>
cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] xtables-addons: geoip: update scripts for DBIP
 names, etc.
In-Reply-To: <20200512002747.2108-1-philipp@redfish-solutions.com>
Message-ID: <nycvar.YFH.7.77.849.2005121118260.6562@n3.vanv.qr>
References: <20200512002747.2108-1-philipp@redfish-solutions.com>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Tuesday 2020-05-12 02:27, Philip Prindeville wrote:
>
>Also change the default destination directory to /usr/share/xt_geoip
>as most distros use this now.  Update the documentation.

This would break the current expectation that an unprivileged user,
using an unmodified incantation of the command, can run the program
and not run into a permission error.

Maybe there are some "nicer" approaches? I'm calling for further inspirations.

>-my $target_dir = ".";
>+my $target_dir = "/usr/share/xt_geoip";
