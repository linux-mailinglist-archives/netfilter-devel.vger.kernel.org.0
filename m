Return-Path: <netfilter-devel+bounces-10601-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMQnBKmagmkzWwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10601-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 02:02:33 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B726EE0372
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 02:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90BED3063107
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 01:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A3D6F2F2;
	Wed,  4 Feb 2026 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="FCFVnOmg"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B431849C;
	Wed,  4 Feb 2026 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166828; cv=none; b=HLMknWS3yr0FoD1rbEnPYSU+JxUGhgi7tLTq03qIT1ikHBCQDDlF5aSxdxsUr36YOQKcEF8rvNJuKlE1JUfqShw/IQ5mKvgdf5IRpPuYcDlE22nQoWTTP2FZOg1X50XU+rgv03m/AljAfZlnd4jPoJrTx42mYyQ5NIFOTIVVjZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166828; c=relaxed/simple;
	bh=Ft80vlbxKey3m4R0LeLvi4vUfPPD/rA+uhsoveCXxoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=elKIPS5uPYqi9Rw2vCOmbOXwg1Qpoho69BymPTDHggEbJDyNvYHvNoPMBgO3olXzWUYuK7gb7Tq7tpt+4NLybvuRgb9n/2epsIRmyYDSHopk7Vlt89JV9u/AGa5FVBS1BOi/7/Np5gQkO9viqySTywtg82tldKsmVGAix1QwODA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=FCFVnOmg; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 38196606BB;
	Wed,  4 Feb 2026 02:00:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770166824;
	bh=ZcJfjmVWAV7buNPQmv2sFIMWEBJ4LD+fQux7/PDzLUE=;
	h=Date:From:To:Cc:Subject:From;
	b=FCFVnOmg68vxDhqdfVl3qdwoYnFyTAvmaZFXZhnOiDLOGRZuF2gxmF6ihWweBdl8s
	 yUDtJO6DLpmputME3EhpLFnnIYOOLwOIeBZSqFjR5uGAP2CL7HUj21nNTnEpTtT/Xr
	 b42mAP6LyC9xbHvtbf4qxqaT4xWwGyDutFJ5u8OkT1KmSCb58HUdE53GJ8J4S1/k0w
	 L4/5SMk4zzS+r9qgej0Dg0Xm8gOeq7y8MKfgBwGewb9zr8mhMV/HJ1gMz7UtNSJc7j
	 +Bw6ODb6prR+M1qcMJE7HZfh17iIBe+2nfGLz7U+V4Sz8Wv9GthDddx64SEisgZTBZ
	 SQSn3tF1IGClw==
Date: Wed, 4 Feb 2026 02:00:20 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: netfilter@vger.kernel.org, netfilter-announce@lists.netfilter.org,
	lwn@lwn.net
Subject: [ANNOUNCE] conntrack-tools 1.4.9 release
Message-ID: <aYKaJFugoa7l5n44@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nXqxhrFKglGDWqSA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10601-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:url,netfilter.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B726EE0372
X-Rspamd-Action: no action


--nXqxhrFKglGDWqSA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi!

The Netfilter project proudly presents:

        conntrack-tools 1.4.9

This release contains bugfixes, for the conntrack cli:

- skip ENOSPC on updates when ct label is not available
- don't print [USERSPACE] information in case of XML output
- fix parsing of tuple-port-src and tuple-port-dst
- improve --secmark,--id,--zone parser
- improve --mark parser
- fix for ENOENT in delete to align behaviour with updates
- fix compiler warnings with -Wcalloc-transposed-args
- prefer kernel-provided event timestamp via CTA_TIMESTAMP_EVENT
  if it is available
- introduce --labelmap option to specify connlabel.conf path
- Extend error message for EBUSY when registering userspace helper

and the conntrackd daemon:

- don't add expectation table entry for RPC portmap port
- fix signal handler race-condition
- restrict multicast reception, otherwise multicast sync messages
  can be received from any interface if your firewall policy does
  not restrict the interface used for sending and receiving them.
- remove double close() in multicast resulting in EBADFD

You can download the new release from:

https://netfilter.org/projects/conntrack-tools/downloads.html#conntrack-tools-1.4.9

To build the code, updated libnetfilter_conntrack 1.1.1 is required:

https://netfilter.org/projects/libnetfilter_conntrack/downloads.html#libnetfilter_conntrack-1.1.1

In case of bugs and feature requests, file them via:

* https://bugzilla.netfilter.org

Happy firewalling.

--nXqxhrFKglGDWqSA
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="changes-conntrack-tools-1.4.9.txt"
Content-Transfer-Encoding: 8bit

Ahelenia Ziemiańska (1):
      conntrack: -L doesn't take a value, so don't discard one (same for -IUDGEFA)

Christoph Heiss (2):
      conntrack: move label parsing to after argument parsing
      conntrack: introduce --labelmap option to specify connlabel.conf path

Donald Yandt (2):
      conntrackd: prevent memory loss if reallocation fails
      conntrackd: exit with failure status

Florian Westphal (2):
      conntrack: prefer kernel-provided event timestamp if it is available
      conntrack: --id argument is mandatory

Ignacy Gawędzki (1):
      conntrack: don't print [USERSPACE] information in case of XML output

Markus Breitenberger (1):
      conntrackd: Fix signal handler race-condition

Pablo Neira Ayuso (8):
      conntrack: ct label update requires proper ruleset
      tests: conntrack: missing space before option
      conntrack: improve --secmark,--id,--zone parser
      conntrack: improve --mark parser
      conntrackd: restrict multicast reception
      conntrackd: remove double close() in multicast resulting in EBADFD
      conntrackd: update netns test to support IPv6
      conntrack-tools 1.4.9 release

Pfeil Daniel (1):
      conntrackd: helpers/rpc: Don't add expectation table entry for portmap port

Phil Sutter (3):
      conntrack: Fix for ENOENT in mnl_nfct_delete_cb()
      src: Eliminate warnings with -Wcalloc-transposed-args
      nfct: helper: Extend error message for EBUSY

Stephan Brunner (1):
      conntrack: tcp: fix parsing of tuple-port-src and tuple-port-dst

Xavier Claude (1):
      conntrackd.conf.5: fix typos


--nXqxhrFKglGDWqSA--

