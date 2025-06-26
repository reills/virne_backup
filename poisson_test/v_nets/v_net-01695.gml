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
  id 1695
  arrival_time 37657.59695870307
  lifetime 454.9560671987944
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 48
    gpu 14
    rom 17
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 33
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 4
    gpu 21
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 42
    rom 42
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 40
    rom 2
  ]
  node [
    id 5
    label "5"
    cpu 28
    gpu 25
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 2
    rom 25
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 26
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 10
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
]
