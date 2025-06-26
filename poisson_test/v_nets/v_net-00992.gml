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
  id 992
  arrival_time 21165.956021366925
  lifetime 813.8336740016357
  num_nodes 2
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 9
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 43
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 22
  ]
]
