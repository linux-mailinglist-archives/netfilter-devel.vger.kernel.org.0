Return-Path: <netfilter-devel+bounces-7658-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F4AEDD5D
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Jun 2025 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C130D189AF91
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Jun 2025 12:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDDE1DF974;
	Mon, 30 Jun 2025 12:45:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA21DFF7
	for <netfilter-devel@vger.kernel.org>; Mon, 30 Jun 2025 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287548; cv=none; b=p4KlTTmh7PTQa4mRw/Yy52fGjylPR6Kle5N+K407NsLJHkB5DY5SJm64iNmyqfJBLtyJ6Oq7rscnVWbWHx21lYyR4e20P9APx+MvWmZPCvRHFUKpP42qqzJGsNe/gQqNydkxh7cdhzgBLfq7CAbcpG/U2/RavjQZGoHcEkYMNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287548; c=relaxed/simple;
	bh=85hqbjASl4qtGS7b7DR/MdnuXdBDrXoyJ4DTv9RNdCw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FCMQh/KgtXJSFv1qKSAOvmwgnfnmdqypimCfSz+t4EB+g32glNddSYYJqTV4L479NP2IXDjMY3KWBE62X6ueEBVtNlvqu1QAU4NzzYg5nUo5UFJRjNhBzf2vmCk2IBOaSv4IzJ3LEqf9a4+ANpqzFX4aUlH186s/uMeuYimieV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4042260E55; Mon, 30 Jun 2025 14:45:38 +0200 (CEST)
Date: Mon, 30 Jun 2025 14:45:37 +0200
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Subject: More json files pushed to nftables.git
Message-ID: <aGKG8XVFHSf3uqxT@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This is a heads-up that I pushed a large number of json dump files
and a few .nft dump files to nftables shell tests.

I didn't see value in sending them as patches first because its just
very boring.

The batch contains no src/ or include/ changes and the only shell
script altered is a simple update to tools/check-tree.sh.

Let me know if you encounter any issues because of this.

