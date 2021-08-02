Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4433DD2B0
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Aug 2021 11:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhHBJMs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Aug 2021 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhHBJMr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:12:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83657C06175F
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Aug 2021 02:12:38 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mATzw-0002ck-R3; Mon, 02 Aug 2021 11:12:36 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH] conntrack-tools: support conntrack dump status filtering
Date:   Mon,  2 Aug 2021 11:12:27 +0200
Message-Id: <20210802091231.1486-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These changes to libnetfilter-conntrack and conntrack-tools allow to
dump  the connection tracking table while suppressing entries that
lack the given status bits.

This allows for example to limit the dump rquest to only contain
entries that did not yet see a reply.

First patch syncs the embedded uapi header with that of nf-next,
second patch adds the status dump filter glue to libnetfilter-conntrack.

Patch 3 is the main change.
Patch 4 adds support for the simpler 'UNREPLIED' keyword, this seems
easier to use than to ask for '!SEEN_REPLY'.


