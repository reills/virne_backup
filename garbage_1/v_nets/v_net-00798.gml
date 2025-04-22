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
  id 798
  arrival_time 16640.20759414632
  lifetime 71.19760516430868
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 49
    gpu 33
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 11
    gpu 14
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 33
    gpu 4
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 21
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 41
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 12
    rom 34
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 39
    rom 16
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 10
  ]
  edge [
    source 2
    target 3
    bw 46
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 35
  ]
  edge [
    source 5
    target 6
    bw 2
  ]
]
