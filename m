Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519C0227B72
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jul 2020 11:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgGUJQD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jul 2020 05:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgGUJQD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:16:03 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FEFC061794
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:16:03 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8688E59B99E83; Tue, 21 Jul 2020 11:16:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 834D660C4008F;
        Tue, 21 Jul 2020 11:16:00 +0200 (CEST)
Date:   Tue, 21 Jul 2020 11:16:00 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons] doc: fix quoted string in libxt_DNETMAP
 man-page.
In-Reply-To: <20200721083136.710735-1-jeremy@azazel.net>
Message-ID: <nycvar.YFH.7.77.849.2007211114060.23166@n3.vanv.qr>
References: <20200721083136.710735-1-jeremy@azazel.net>
User-Agent: Alpine 2.22 (LSU 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tuesday 2020-07-21 10:31, Jeremy Sowden wrote:

>In roff, lines beginning with a single quote are control lines.  In the
>libxt_DNETMAP man-page there is a single-quoted string at the beginning
>of a line, which troff tries and fails to interpret as a macro:

Is there some escaping magic available that would make this work as 
well? I would fear that if the next person (me included) comes around 
to use an editor's "wrap at 80 cols" feature, that the quote might 
re-shift to the start of line. If all else, I'd just pick " over ' - in 
the hope that that does not have a special meaning.

>-boot time). Please note that the \fBttl\fR and \fBlasthit\fR entries contain an
>-'\fBS\fR' in case of a static binding.
>+boot time). Please note that the \fBttl\fR and \fBlasthit\fR entries contain
>+an '\fBS\fR' in case of a static binding.
