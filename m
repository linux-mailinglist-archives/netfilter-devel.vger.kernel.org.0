Return-Path: <netfilter-devel+bounces-10345-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKfyLKbpb2m+UQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10345-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 21:46:30 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED84BB5E
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 21:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD53AE988
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB26B3A4F57;
	Tue, 20 Jan 2026 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBOZTf74"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64673A4AA0
	for <netfilter-devel@vger.kernel.org>; Tue, 20 Jan 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938800; cv=none; b=NA6cXy21al4zrUPnk3o0mKH0Mnn04KGBhgHi9BMdG7rxDDVefJD1DuqG+1X6CNf8fnX19wSGTtqMqD3bXg5Mld19QcHJd3EZhJzBjIAcAwqM8EcJAB+9aP+37UpunkHu1e2oFz56xCfhlbJdYT7sXQMgt6XAcXFl6ushgYGjZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938800; c=relaxed/simple;
	bh=gCKKVMteQwPhne3YDNwAWsEZNKOxInJ5K3aKpxBslr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fz2DLmPJko9QpD3s6p42rj9eOJgInUG46PrWN8iDiJGPUJAVYDKqg0cGhM5Q0Sw7hgeiG9B0kEEbRtQp725XD39EVszJ9Cv003JYCrHm39JsEVsxzQPD8hi8g8g8MAbJ1oe1jiMby23IbVJFne8QDAtIpzpQn8AfRcCV1+naxkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBOZTf74; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee807a4c5so43712135e9.2
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Jan 2026 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768938796; x=1769543596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+4shdj8S0/P4hFdRXBJYtF2wW3omPkyDtv3uIIVJjJ4=;
        b=EBOZTf74WW+hmIeNePL/MdyVe3UhBdaJeoZmtElrVMfT3uV0FSs1UZEByfH8LN3uxf
         ZoCDF8AJLl4BqZSlT9VcMjKf9H5HeJ8Juer9ZivIJUk/HeXTCmcjRarjY1X3EJjMbaqm
         s0QH6hD+zFvGfpvtGq5fxnyVBPhOIVCuxkF0pmNS3T7ycdtLh/cj9NYBtxvFsdp1xZ5H
         v+uUaliFR2tWxpZT3S0QuaMggBecrf9dWGsU9wI+KbeQE8R+uds7FwwjrVC9c0EbQLDZ
         ZlxHaStAUF7VvUFDIBPyyYPM5HqUw0jltl426PPeLETCEtR5/aamSnwjPczLlnD7zAbe
         5PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938796; x=1769543596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4shdj8S0/P4hFdRXBJYtF2wW3omPkyDtv3uIIVJjJ4=;
        b=STa5KVbx4LxGKWtl9suVqkFiBcKLSU24BKlNB+YqqyJZnM7ZPJ/LAThY2GgD8H+voh
         cwgXZlit+zQ2FelEqu/PNJfTqHsRJCW5iAwLz2GEUYIfia7u8lIIg63kFJtCUZGY+1V3
         bXiupCaRMQejBLqVM91GiYHWV1fQYs5DUYshQFw1/603iMhGMBw7yCL3zK8vrFTdC4Xu
         WRbhjrXQag6AxSQHB0Zw5qrXGPY5iJ+KYcCWAapUxIPLDnc+13PjOr8VILlvGbjyfaXc
         GBMQCE+gccPUisyqUTwEFvTJMh1C+ToGgXqnILzl8VXIwmnyTQYuqnE1Xuk/5FbpcxWP
         sDZQ==
X-Gm-Message-State: AOJu0Ywg8jKFM7KpXzY+Y7GbFSkJvtBmzzKJXQ6T2fbZLOe5EnES2eBM
	jK1dlOZnDW4xuOkiBLGrhtnKbqymU/FU/YH5FqxKTKktB8iLP8uZdTIP44jRBQ==
X-Gm-Gg: AY/fxX4izZg+mG35vWf7ct7YX24fMlB74KIthQKPcyLSecaLVoRaUd/a912H9wDkdie
	d149TqPfuAk6evI6VzgKfynQEVOC839f5FByvFFS752ojuaAnWmFlw8q6oPjIMOyRILQiB65C2z
	vsBWZBs1gh4M8yrZ5rBRekAHGFkl8z4snyj0jBqrw4GOqbzDvtN9eXMhTCUX96pgdZ4Do+IW4T5
	ad9uG/YOUANCnot2NcgErmzBrYOrOdJt3aIXOpx7es0hnIGodUwVCF5Qn5hnAsGarX9H5DhvKIZ
	/0x1iEJVfvp2ukIfm3oSHZTE5uaAGyZqA/qtazf2rubsggdpjrM26w2rOWCcYFaPO8sKSNaP5Ze
	89psvlbnWOzwjFLtgar+FF7990ImCcFthXFw3Av5uoCI5EGMF4UbMAjsdqzEJ7dsTC3yZsLM/Rn
	fgK/hi6xjhzKwf8stFVImf0oHU6zoHlS0=
X-Received: by 2002:a05:600c:8710:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4801eb142famr194084135e9.33.1768938796226;
        Tue, 20 Jan 2026 11:53:16 -0800 (PST)
Received: from bluefin ([2a01:cb1c:8441:2b00:c694:3c2c:878b:f4c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4289b789sm320114165e9.1.2026.01.20.11.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:53:15 -0800 (PST)
From: Alexandre Knecht <knecht.alexandre@gmail.com>
To: netfilter-devel@vger.kernel.org
Cc: phil@nwl.cc,
	fw@strlen.de,
	Alexandre Knecht <knecht.alexandre@gmail.com>
Subject: [PATCH v6 0/3] parser_json: support handle for rule positioning
Date: Tue, 20 Jan 2026 20:53:00 +0100
Message-ID: <20260120195303.1987192-1-knecht.alexandre@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10345-lists,netfilter-devel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nwl.cc,strlen.de,gmail.com];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[knechtalexandre@gmail.com,netfilter-devel@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 68ED84BB5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series enables handle-based rule positioning for JSON
add/insert commands.

Changes since v5:
- Merged nested if-conditionals, sorted expressions cheap to expensive
  (Phil feedback)
- Use Reverse Christmas Tree notation for variable declarations
  (Phil feedback)
- Test 0007: Use $DIFF to verify ruleset state after ADD operations
  instead of just checking command success (Phil feedback)

Changes since v4:
- CTX_F_EXPR_MASK now uses inverse mask (UINT32_MAX & ~(...)) as
  suggested by Phil, for future-proof expression flag filtering
- Removed nested block in json_parse_cmd(), variables declared at
  function start per project style (Phil/Florian feedback)
- Test 0007: Removed redundant insert position check (covered by 0008),
  replaced grep|grep|awk with single sed call
- Test 0008: Added test for insert without handle, added test for
  multiple commands in single transaction, fixed error message typo
- Added .json-nft dump files for both tests

All JSON tests pass. check-tree.sh shows no new errors.

Alexandre Knecht (3):
  parser_json: support handle for rule positioning in explicit JSON
    format
  tests: shell: add JSON test for all object types
  tests: shell: add JSON test for handle-based rule positioning

 src/parser_json.c                             |  36 +++-
 .../json/0007add_insert_delete_objects_0      | 163 ++++++++++++++++++
 .../testcases/json/0008rule_position_handle_0 | 162 +++++++++++++++++
 .../0007add_insert_delete_objects_0.json-nft  |  18 ++
 .../dumps/0007add_insert_delete_objects_0.nft |   2 +
 .../dumps/0008rule_position_handle_0.json-nft |  76 ++++++++
 .../json/dumps/0008rule_position_handle_0.nft |   6 +
 7 files changed, 460 insertions(+), 3 deletions(-)
 create mode 100755 tests/shell/testcases/json/0007add_insert_delete_objects_0
 create mode 100755 tests/shell/testcases/json/0008rule_position_handle_0
 create mode 100644 tests/shell/testcases/json/dumps/0007add_insert_delete_objects_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0007add_insert_delete_objects_0.nft
 create mode 100644 tests/shell/testcases/json/dumps/0008rule_position_handle_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0008rule_position_handle_0.nft

-- 
2.51.1


