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
  id 659
  arrival_time 13958.888844967738
  lifetime 426.4328985666684
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 41
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 46
    rom 12
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 8
    rom 0
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 27
    rom 26
  ]
  node [
    id 4
    label "4"
    cpu 12
    gpu 20
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 48
    rom 20
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 17
    rom 18
  ]
  edge [
    source 0
    target 1
    bw 9
  ]
  edge [
    source 1
    target 2
    bw 29
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 35
  ]
]
