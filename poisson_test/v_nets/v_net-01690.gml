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
  id 1690
  arrival_time 37616.161363179155
  lifetime 618.4284413156997
  num_nodes 5
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 6
    rom 48
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 18
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 2
    gpu 9
    rom 47
  ]
  node [
    id 3
    label "3"
    cpu 26
    gpu 30
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 45
    gpu 36
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 36
  ]
  edge [
    source 1
    target 2
    bw 48
  ]
  edge [
    source 2
    target 3
    bw 11
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
]
