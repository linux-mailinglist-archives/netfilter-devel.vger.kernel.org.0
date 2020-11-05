Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EA2A8076
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Nov 2020 15:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbgKEOLy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Nov 2020 09:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKEOLy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:11:54 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FAFC0613CF
        for <netfilter-devel@vger.kernel.org>; Thu,  5 Nov 2020 06:11:54 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1kafzS-0006G4-L8; Thu, 05 Nov 2020 15:11:50 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft 0/7] rework tcp option handling
Date:   Thu,  5 Nov 2020 15:11:37 +0100
Message-Id: <20201105141144.31430-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reworks how tcp options are handled in nft internally.
First patches refactor and condense code.

In particular, it removes the duplication of 'sack-perm'/permitted
maxseg/mss lexer keys -- synproxy and tcp option used different tokens,
leading to confusing sytax errors when using the 'wrong' word in the
'wrong' place.

patch 5 is the first one with a new feature: it allows to check for
presence of any tcp option kind, i.e. 'tcp option $number'.
patch 6 and 7 add 'raw' payload matching for tcp options to allow
testing for tcp options that do not have an internal template.


