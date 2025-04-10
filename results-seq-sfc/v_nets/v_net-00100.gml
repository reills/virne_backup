graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 100
  arrival_time 1962.0570969456007
  lifetime 1252.7697155446672
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 2
    gpu 47
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 28
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 21
    gpu 39
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 20
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 45
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 39
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 10
    gpu 16
    rom 31
  ]
  node [
    id 7
    label "7"
    cpu 42
    gpu 29
    rom 26
  ]
  node [
    id 8
    label "8"
    cpu 22
    gpu 42
    rom 14
  ]
  node [
    id 9
    label "9"
    cpu 32
    gpu 28
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 24
    gpu 45
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 27
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 38
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 3
  ]
  edge [
    source 6
    target 7
    bw 36
  ]
  edge [
    source 7
    target 8
    bw 23
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 32
  ]
]
