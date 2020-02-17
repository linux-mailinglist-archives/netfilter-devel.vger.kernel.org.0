Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03E160F58
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Feb 2020 10:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgBQJyI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Feb 2020 04:54:08 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39856 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729025AbgBQJyI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:54:08 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1j3d6N-0008Lv-M3; Mon, 17 Feb 2020 10:54:07 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 0/2] netfilter: nf_tables: make sets built-in
Date:   Mon, 17 Feb 2020 10:53:57 +0100
Message-Id: <20200217095359.22791-1-fw@strlen.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There is little to no technical reason to have an extra kconfig knob for
this; nf_tables main use case it levaraging set infrastructure for
decisions/packet classification.

Also there were number of bug reports that turned out to be
caused by builds with nftables enabled and sets disabled.

This removes the set kconfig knob and places set infra in the nf_tables
core.

